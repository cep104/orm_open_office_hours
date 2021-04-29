class Seed 
    def self.get_data 
        Character.create({name:"Homer Simpson", age:"55"})
        Character.create({name:"Lisa Simpson", age:"8"})
        Character.create({name:"Bart Simpson", age:"10"})
        Character.create({name:"Maggie Simpson", age:"1"})
        Character.create({name:"Marge Simpson", age:"45"})

    end
end
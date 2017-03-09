From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/3] firmware: dmi_scan: Add dmi_product_name kernel
 cmdline option
Date: Thu, 9 Mar 2017 11:43:52 +0100
Message-ID: <5dd43c51-789b-2e73-4e6c-9527a6806c33@redhat.com>
References: <20170225172357.26294-1-hdegoede@redhat.com>
 <20170225172357.26294-2-hdegoede@redhat.com>
 <20170303102412.52d4b692@endymion>
 <43efc13a-d2f9-3fde-c7c0-0471bb6bfc2d@redhat.com>
 <1489053541.3806.44.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1489053541.3806.44.camel@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Takashi Iwai <tiwai@suse.de>, russianneuromancer@ya.ru, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 09-03-17 10:59, Jean Delvare wrote:
> Hi Hans,
>
> On ven., 2017-03-03 at 15:27 +0100, Hans de Goede wrote:
>> On 03-03-17 10:24, Jean Delvare wrote:
>>> On Sat, 25 Feb 2017 18:23:55 +0100, Hans de Goede wrote:
>>>> 1) Rather then add cmdline options for all things which can be DMI quirked
>>>> and thus may need to be specified, this only requires adding code for
>>>> a single extra cmdline option
>>>
>>> This cuts both ways. It also means that, if you get a new machine which
>>> needs some of the quirks needed by an older machine, but not all of
>>> them, you can't get it to work without modifying your kernel first. If
>>> quirk options are addressed directly to the relevant subsystem, then
>>> there is a chance that they can be reused directly for other machines
>>> later.
>>
>> Quirks being applied for issues which may be fixed by e.g. a BIOS update
>> already always being applied even if the new BIOS is there already is the
>> case for any DMI based quirks.
>
> I'm afraid you did not get my point. By "new machine", I did not mean a
> new hardware or BIOS iteration of the same machine. I meant a
> completely different machine.

I see.

> Say you implemented 4 quirks for machine Foo from vendor A, and mapped
> them to dmi_product_name=A-Foo. Then vendor B releases machine Bar,
> which needs 2 of the quirks that machine Foo needed, but not the other
> 2. You can't pass dmi_product_name=A-Foo for machine Bar, you have to
> add kernel code to handle dmi_product_name=B-Bar.

Right, just as we would if the new machine had proper dmi strings in
the first place and chances are really good (luckily) that machine-B
will have a proper dmi string, so we would add the new quirks even
without the A machine having them via the dmi_product_name hack, since
we will want things to work ootb where-ever possible.

> If instead you had implemented 4 individually-enabled quirks for
> machine Foo, you could reuse them directly for machine Bar, without
> requiring kernel changes.

True, but as said many many drivers now have quirks which can only
be enabled through dmi since that is always the end game, so that
things will work ootb. This seems orthogonal to out discussion.

> And as a side note, your claim that we keep applying quirks on newer
> BIOS iterations isn't entirely true. Grep the kernel tree for
> "dmi_get_system_info(DMI_BIOS_VERSION)" or
> "DMI_MATCH(DMI_BIOS_VERSION". Sometimes applying a quirk which is not
> needed is harmless, but most of the time it must be avoided.

True.

>>>> 2) Some devices can be quite quirky, e.g. the GPD win mini laptop /
>>>> clamshell x86 machine, needing several quirks in both kernel and userspace
>>>> (udev hwdb) in this case being able to fake a unique dmi product name
>>>> allows making these devices usable with a single kernel cmdline option
>>>> rather then requiring multiple kernel cmdline options + manual userspace
>>>> tweaking
>>>>
>>>> 3) In some case we may be able to successfully get the manufacturer to
>>>> fix the DMI strings with a firmware update, but not all users may want
>>>> to update, this will allow users to use DMI based quirks without forcing
>>>> them to update their firmware
>>>
>>> But that's the only right thing to do. The easier we make it for
>>> manufacturers shipping crappy BIOSes, the lesser motivated they will be
>>> to fix them. Writing a decent DMI table is a one hour job, there's no
>>> excuse for not doing it. So I am very reluctant to accept this patch,
>>> sorry.
>>
>> This whole we are going to make users live miserable to pressure manufacturers
>> into doing the right thing does not work. We (the kernel community) have
>> tried that for 10 years and not a whole lot has changed and in the cases
>> where things have changed it was not because of this it was because
>> there was a business case for FOSS drivers. Unfortunately there is not
>> a whole lot of business case for correct DMI strings (for consumer hw).
>
> Actually, as the maintainer of dmidecode, my feeling is that the
> quality of DMI tables has increased significantly over time. That a
> vendor dared to ship a system in 2016 with not even a valid product
> name in the DMI table stunned me, I have to admit. Thankfully it is an
> exception. What you have in your system is the lowest possible degree
> of DMI table quality :-(

Yeah.

> I really believe that Linux is where it is now because we said no when
> we had to say no. Quality and maintainability comes at this price.
>
>> So lets not make users live harder then it needs to be.
>
> Users who buy crappy hardware have made their decision. I am not going
> to make their life harder on purpose, but I am also not going to let
> them influence the direction of Linux kernel development.

This specific machine is not crappy (although the DMI tables are)
and fills a niche where there is almost 0 choice.

> You also have to consider what kind of user is going to install Linux
> on such machines. If it requires any kind of manual tweaking (as even
> your proposal does) then you can exclude the majority of owners. The
> remaining few percents will find their way through instructions, even
> if they require several steps.

Still I would like to make things as easy as possible and unfortunately
adding kernel cmdline tweaks is something which quite a few users
eventually end up doing, so this is well documented.

>> We're talking about either giving the users this set of instructions:
>>
>> a)  Add dmi_product_name=GPD-WINI55 to your kernel commandline, then
>> reboot
>>
>> or:
>>
>> b)
>> 1) Add "quirk1=foo quirk2=bar quirk3=argh quirk4=uhoh" to your kernel cmdline.
>> 2) Edit /lib/udev/hwdb/99-local.hwdb, Add:
>>
>> sensor:modalias:acpi:KIOX000A*:dmi*:
>>   ACCEL_MOUNT_MATRIX=1, 0, 0; 0, -1, 0; 0, 0, 1
>>
>> 3) As root run: "udevadm hwdb --update"
>> 4) reboot
>>
>> Which one is more userfriendly?
>
> The answer is obvious, but it would be more honest to present the two
> options with a neutral point of view. You made "reboot" a separate step
> in b), not in a). Also steps 2 and 3 of b) are the same thing, really.
> With more neutrality, a) would still be shorter than b), but the
> difference would be smaller.
>
>> Esp. the ability to have a single kernel cmdline option influence both
>> kernel and userspace behavior (by allowing a pre-existing rule for the
>> hw to exist in hwdb) is important since now a days quirks are
>> more or less split 50/50 between the 2.

This to me is the most important reason for wanting this, without
the dmi_product_name= hack (I admit it is a hack) we cannot have userspace
quirks unless we get the user to unconditionally add them.

Another big advantage of the dmi_product_name= hack (I admit it is
a hack) is that we can add new quirks as we discover the need for
them, e.g as we do hardware enablement for more bits and pieces
(such as battery monitoring) on the machine and users will then get
these automatically applied when they install a new kernel.

>> So I would really like to see support for this kernel cmdline option merged.
>> Takashi Iwai has been working on some quirks for headphone detection for
>> the GPDwin machine, which also rely on being able to use a fake dmi_id to
>> identify the machine.
>
> I'll discuss that with Takashi when he returns from vacation.

Ok, lets wait for that then.

>> And we will likely hit the same problem with intel based tables using
>> silead touchscreens which also require extra platform info not available
>> in the ACPI tables, which currently also gets automatically added based
>> on dmi data, see:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/silead_dmi.c
>
> And what makes you think that systems with crappy DMI data using such
> touchscreen devices will exist?

Because these touchscreens are used in the cheapest tablets available,
so I'm afraid we will eventually hit one with DMI data as bad as the
GPD-win

>> If you look at the amount of info we need per tablet here doing this
>> through the kernel cmdline is going to be quite painful. Also the needed
>> extra code to be able to specify this and many other quirks which are
>> currently only settable through dmi on the kernel cmdline will be many
>> times more then the code for the dmi_product_name kernel cmdline
>> option.
>
> I'm not disputing the potential usefulness of the feature. But I see
> that you are implementing the minimal solution that addresses your
> immediate problem, with little consideration for where it will lead us
> in the long term.

That is a bit of a vague statement if you foresee specific problems
with this patch in the future please state them.

> One thing that strikes me is that "GPD-WINI55" isn't a "DMI product
> name".

AFAICT there really is no clear definition (in practice) of what goes
into the product-name people in general identify this machine as the
GPDwin or GPD win so to me that is the product name, also I did not
want to also add a dmi_sys_vendor kernel cmdline argument since just
having a unique product name string is enough and that would double
the code added for this hack.

> For one thing, you insist on mapping it to DMI for convenience,
> but it means you are excluding all architectures which do not support
>  DMI.

True, but other architectures have e.g. devicetree where we can fix
this with an updated .dtb file.

> Also GPD is the manufacturer name, not the product name.

See my answer to why GPD is included in the product name above, in
practice everyone calls the product the "GPD win" just doing a web-
search for "win" is not going to find you anything useful.

> I'm not sure
> what the "I55" part comes from, I couldn't find any reference to it on
> the vendor site. Did you craft it from the fact that this model comes
> with a 5.5 inches screen?

I wanted something more specific then GPD win in case GPD releases
a new significantly different version. The PCB is marked WINI55
so that is where that comes from.

 > You bundle the whole thing to a single
> arbitrary string, it looks like a hack, it's not clean. And it's not
> safe either, as the product name space is per-vendor, so checking for
> the DMI product name without first checking for the system vendor could
> lead to unexpected matches (imagine another vendor releases a machine
> where the full product name is "GPD-WINI55".)

There are many examples where dmi matches are done only on the
product_name, or any other dmi string as long as it seems unique,
I don't see this bit as a problem, but if you want to also add a
dmi_sys_vendor kernel cmdline argument, sure we can do that.

> Where are you with the vendor, when do they plan to ship that BIOS
> update that would solve the problem so nicely?

They are not answering on either their forum or their contact email
address from there webpage :|


Anyways lets wait for Takashi to get back from vacation and you've
had a discussion with him about this and then we will see from
there.

Regards,

Hans

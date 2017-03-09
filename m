From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 1/3] firmware: dmi_scan: Add dmi_product_name kernel
 cmdline option
Date: Thu, 09 Mar 2017 10:59:01 +0100
Message-ID: <1489053541.3806.44.camel@suse.de>
References: <20170225172357.26294-1-hdegoede@redhat.com>
         <20170225172357.26294-2-hdegoede@redhat.com>
         <20170303102412.52d4b692@endymion>
         <43efc13a-d2f9-3fde-c7c0-0471bb6bfc2d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50064 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754510AbdCIJ7F (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 9 Mar 2017 04:59:05 -0500
In-Reply-To: <43efc13a-d2f9-3fde-c7c0-0471bb6bfc2d@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Takashi Iwai <tiwai@suse.de>, russianneuromancer@ya.ru, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Hans,

On ven., 2017-03-03 at 15:27 +0100, Hans de Goede wrote:
> On 03-03-17 10:24, Jean Delvare wrote:
> > On Sat, 25 Feb 2017 18:23:55 +0100, Hans de Goede wrote:
> > > 1) Rather then add cmdline options for all things which can be DMI quirked
> > > and thus may need to be specified, this only requires adding code for
> > > a single extra cmdline option
> > 
> > This cuts both ways. It also means that, if you get a new machine which
> > needs some of the quirks needed by an older machine, but not all of
> > them, you can't get it to work without modifying your kernel first. If
> > quirk options are addressed directly to the relevant subsystem, then
> > there is a chance that they can be reused directly for other machines
> > later.
> 
> Quirks being applied for issues which may be fixed by e.g. a BIOS update
> already always being applied even if the new BIOS is there already is the
> case for any DMI based quirks.

I'm afraid you did not get my point. By "new machine", I did not mean a
new hardware or BIOS iteration of the same machine. I meant a
completely different machine.

Say you implemented 4 quirks for machine Foo from vendor A, and mapped
them to dmi_product_name=A-Foo. Then vendor B releases machine Bar,
which needs 2 of the quirks that machine Foo needed, but not the other
2. You can't pass dmi_product_name=A-Foo for machine Bar, you have to
add kernel code to handle dmi_product_name=B-Bar.

If instead you had implemented 4 individually-enabled quirks for
machine Foo, you could reuse them directly for machine Bar, without
requiring kernel changes. 

And as a side note, your claim that we keep applying quirks on newer
BIOS iterations isn't entirely true. Grep the kernel tree for
"dmi_get_system_info(DMI_BIOS_VERSION)" or
"DMI_MATCH(DMI_BIOS_VERSION". Sometimes applying a quirk which is not
needed is harmless, but most of the time it must be avoided.

> > > 2) Some devices can be quite quirky, e.g. the GPD win mini laptop /
> > > clamshell x86 machine, needing several quirks in both kernel and userspace
> > > (udev hwdb) in this case being able to fake a unique dmi product name
> > > allows making these devices usable with a single kernel cmdline option
> > > rather then requiring multiple kernel cmdline options + manual userspace
> > > tweaking
> > > 
> > > 3) In some case we may be able to successfully get the manufacturer to
> > > fix the DMI strings with a firmware update, but not all users may want
> > > to update, this will allow users to use DMI based quirks without forcing
> > > them to update their firmware
> > 
> > But that's the only right thing to do. The easier we make it for
> > manufacturers shipping crappy BIOSes, the lesser motivated they will be
> > to fix them. Writing a decent DMI table is a one hour job, there's no
> > excuse for not doing it. So I am very reluctant to accept this patch,
> > sorry.
> 
> This whole we are going to make users live miserable to pressure manufacturers
> into doing the right thing does not work. We (the kernel community) have
> tried that for 10 years and not a whole lot has changed and in the cases
> where things have changed it was not because of this it was because
> there was a business case for FOSS drivers. Unfortunately there is not
> a whole lot of business case for correct DMI strings (for consumer hw).

Actually, as the maintainer of dmidecode, my feeling is that the
quality of DMI tables has increased significantly over time. That a
vendor dared to ship a system in 2016 with not even a valid product
name in the DMI table stunned me, I have to admit. Thankfully it is an
exception. What you have in your system is the lowest possible degree
of DMI table quality :-(

I really believe that Linux is where it is now because we said no when
we had to say no. Quality and maintainability comes at this price.

> So lets not make users live harder then it needs to be.

Users who buy crappy hardware have made their decision. I am not going
to make their life harder on purpose, but I am also not going to let
them influence the direction of Linux kernel development.

You also have to consider what kind of user is going to install Linux
on such machines. If it requires any kind of manual tweaking (as even
your proposal does) then you can exclude the majority of owners. The
remaining few percents will find their way through instructions, even
if they require several steps.

> We're talking about either giving the users this set of instructions:
> 
> a)  Add dmi_product_name=GPD-WINI55 to your kernel commandline, then
> reboot
> 
> or:
> 
> b)
> 1) Add "quirk1=foo quirk2=bar quirk3=argh quirk4=uhoh" to your kernel cmdline.
> 2) Edit /lib/udev/hwdb/99-local.hwdb, Add:
> 
> sensor:modalias:acpi:KIOX000A*:dmi*:
>   ACCEL_MOUNT_MATRIX=1, 0, 0; 0, -1, 0; 0, 0, 1
> 
> 3) As root run: "udevadm hwdb --update"
> 4) reboot
> 
> Which one is more userfriendly?

The answer is obvious, but it would be more honest to present the two
options with a neutral point of view. You made "reboot" a separate step
in b), not in a). Also steps 2 and 3 of b) are the same thing, really.
With more neutrality, a) would still be shorter than b), but the
difference would be smaller.

> Esp. the ability to have a single kernel cmdline option influence both
> kernel and userspace behavior (by allowing a pre-existing rule for the
> hw to exist in hwdb) is important since now a days quirks are
> more or less split 50/50 between the 2.
> 
> So I would really like to see support for this kernel cmdline option merged.
> Takashi Iwai has been working on some quirks for headphone detection for
> the GPDwin machine, which also rely on being able to use a fake dmi_id to
> identify the machine.

I'll discuss that with Takashi when he returns from vacation.

> And we will likely hit the same problem with intel based tables using
> silead touchscreens which also require extra platform info not available
> in the ACPI tables, which currently also gets automatically added based
> on dmi data, see:
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/silead_dmi.c

And what makes you think that systems with crappy DMI data using such
touchscreen devices will exist?

> If you look at the amount of info we need per tablet here doing this
> through the kernel cmdline is going to be quite painful. Also the needed
> extra code to be able to specify this and many other quirks which are
> currently only settable through dmi on the kernel cmdline will be many
> times more then the code for the dmi_product_name kernel cmdline
> option.

I'm not disputing the potential usefulness of the feature. But I see
that you are implementing the minimal solution that addresses your
immediate problem, with little consideration for where it will lead us
in the long term.

One thing that strikes me is that "GPD-WINI55" isn't a "DMI product
name". For one thing, you insist on mapping it to DMI for convenience,
but it means you are excluding all architectures which do not support
DMI.

Also GPD is the manufacturer name, not the product name. I'm not sure
what the "I55" part comes from, I couldn't find any reference to it on
the vendor site. Did you craft it from the fact that this model comes
with a 5.5 inches screen? You bundle the whole thing to a single
arbitrary string, it looks like a hack, it's not clean. And it's not
safe either, as the product name space is per-vendor, so checking for
the DMI product name without first checking for the system vendor could
lead to unexpected matches (imagine another vendor releases a machine
where the full product name is "GPD-WINI55".)

Where are you with the vendor, when do they plan to ship that BIOS
update that would solve the problem so nicely?

-- 
Jean Delvare
SUSE L3 Support

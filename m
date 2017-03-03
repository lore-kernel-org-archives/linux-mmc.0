From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/3] firmware: dmi_scan: Add dmi_product_name kernel
 cmdline option
Date: Fri, 3 Mar 2017 15:27:05 +0100
Message-ID: <43efc13a-d2f9-3fde-c7c0-0471bb6bfc2d@redhat.com>
References: <20170225172357.26294-1-hdegoede@redhat.com>
 <20170225172357.26294-2-hdegoede@redhat.com>
 <20170303102412.52d4b692@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751009AbdCCO3W (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 3 Mar 2017 09:29:22 -0500
In-Reply-To: <20170303102412.52d4b692@endymion>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jean Delvare <jdelvare@suse.com>, Takashi Iwai <tiwai@suse.de>, russianneuromancer@ya.ru, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 03-03-17 10:24, Jean Delvare wrote:
> Hi Hans,
>
> On Sat, 25 Feb 2017 18:23:55 +0100, Hans de Goede wrote:
>> Unfortunately some firmware has all the DMI strings filled with:
>> "Default String" (or something equally useless). This makes it impossible
>> to apply DMI based quirks to certain machines.
>
> Sad but true :-(
>
>> This commit adds a dmi_product_name kernel cmdline option which can
>> be used to override the DMI_PRODUCT_NAME string, so that DMI based
>> quirks can still be used on such boards, there are 3 reasons for this:
>>
>> 1) Rather then add cmdline options for all things which can be DMI quirked
>> and thus may need to be specified, this only requires adding code for
>> a single extra cmdline option
>
> This cuts both ways. It also means that, if you get a new machine which
> needs some of the quirks needed by an older machine, but not all of
> them, you can't get it to work without modifying your kernel first. If
> quirk options are addressed directly to the relevant subsystem, then
> there is a chance that they can be reused directly for other machines
> later.

Quirks being applied for issues which may be fixed by e.g. a BIOS update
already always being applied even if the new BIOS is there already is the
case for any DMI based quirks.

>> 2) Some devices can be quite quirky, e.g. the GPD win mini laptop /
>> clamshell x86 machine, needing several quirks in both kernel and userspace
>> (udev hwdb) in this case being able to fake a unique dmi product name
>> allows making these devices usable with a single kernel cmdline option
>> rather then requiring multiple kernel cmdline options + manual userspace
>> tweaking
>>
>> 3) In some case we may be able to successfully get the manufacturer to
>> fix the DMI strings with a firmware update, but not all users may want
>> to update, this will allow users to use DMI based quirks without forcing
>> them to update their firmware
>
> But that's the only right thing to do. The easier we make it for
> manufacturers shipping crappy BIOSes, the lesser motivated they will be
> to fix them. Writing a decent DMI table is a one hour job, there's no
> excuse for not doing it. So I am very reluctant to accept this patch,
> sorry.

This whole we are going to make users live miserable to pressure manufacturers
into doing the right thing does not work. We (the kernel community) have
tried that for 10 years and not a whole lot has changed and in the cases
where things have changed it was not because of this it was because
there was a business case for FOSS drivers. Unfortunately there is not
a whole lot of business case for correct DMI strings (for consumer hw).

So lets not make users live harder then it needs to be.

We're talking about either giving the users this set of instructions:

a)  Add dmi_product_name=GPD-WINI55 to your kernel commandline, then
reboot

or:

b)
1) Add "quirk1=foo quirk2=bar quirk3=argh quirk4=uhoh" to your kernel cmdline.
2) Edit /lib/udev/hwdb/99-local.hwdb, Add:

sensor:modalias:acpi:KIOX000A*:dmi*:
  ACCEL_MOUNT_MATRIX=1, 0, 0; 0, -1, 0; 0, 0, 1

3) As root run: "udevadm hwdb --update"
4) reboot

Which one is more userfriendly?

Esp. the ability to have a single kernel cmdline option influence both
kernel and userspace behavior (by allowing a pre-existing rule for the
hw to exist in hwdb) is important since now a days quirks are
more or less split 50/50 between the 2.

So I would really like to see support for this kernel cmdline option merged.
Takashi Iwai has been working on some quirks for headphone detection for
the GPDwin machine, which also rely on being able to use a fake dmi_id to
identify the machine.

And we will likely hit the same problem with intel based tables using
silead touchscreens which also require extra platform info not available
in the ACPI tables, which currently also gets automatically added based
on dmi data, see:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/silead_dmi.c

If you look at the amount of info we need per tablet here doing this
through the kernel cmdline is going to be quite painful. Also the needed
extra code to be able to specify this and many other quirks which are
currently only settable through dmi on the kernel cmdline will be many
times more then the code for the dmi_product_name kernel cmdline
option.

Regards,

Hans



>
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Note the GPD win: http://www.gpd.hk/gpdwin.asp is the main reason I wrote
>> this patch. I've requested the manufacturer to do a BIOS update fixing the
>> DMI strings, but I cannot guarantee that that will happen.
>> ---
>>  drivers/firmware/dmi_scan.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
>> index 54be60e..c99e753 100644
>> --- a/drivers/firmware/dmi_scan.c
>> +++ b/drivers/firmware/dmi_scan.c
>> @@ -1047,3 +1047,17 @@ void dmi_memdev_name(u16 handle, const char **bank, const char **device)
>>  	}
>>  }
>>  EXPORT_SYMBOL_GPL(dmi_memdev_name);
>> +
>> +static int __init dmi_parse_dmi_product_name(char *str)
>> +{
>> +	static char prod_name[32];
>> +
>> +	if (!str)
>> +		return -EINVAL;
>> +
>> +	strlcpy(prod_name, str, sizeof(prod_name));
>> +	dmi_ident[DMI_PRODUCT_NAME] = prod_name;
>> +
>> +	return 0;
>> +}
>> +early_param("dmi_product_name", dmi_parse_dmi_product_name);
>
>

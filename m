From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/3] firmware: dmi_scan: Add dmi_product_name kernel
 cmdline option
Date: Tue, 4 Apr 2017 12:21:42 +0200
Message-ID: <d934d06c-5bc7-6eb3-52c3-807bd82609ad@redhat.com>
References: <20170225172357.26294-1-hdegoede@redhat.com>
 <20170225172357.26294-2-hdegoede@redhat.com>
 <20170303102412.52d4b692@endymion>
 <43efc13a-d2f9-3fde-c7c0-0471bb6bfc2d@redhat.com>
 <1489053541.3806.44.camel@suse.de>
 <5dd43c51-789b-2e73-4e6c-9527a6806c33@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5dd43c51-789b-2e73-4e6c-9527a6806c33@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Takashi Iwai <tiwai@suse.de>, russianneuromancer@ya.ru, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.orgTakashi Iwai <tiwai@suse.de>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 09-03-17 11:43, Hans de Goede wrote:
> Hi,
>
> On 09-03-17 10:59, Jean Delvare wrote:

<snip>

>>> So I would really like to see support for this kernel cmdline option merged.
>>> Takashi Iwai has been working on some quirks for headphone detection for
>>> the GPDwin machine, which also rely on being able to use a fake dmi_id to
>>> identify the machine.
>>
>> I'll discuss that with Takashi when he returns from vacation.
>
> Ok, lets wait for that then.

So Takashi is back (and has responded) but in the mean time
I've been thinking about this and tried to find a better solution
as I really want the kernel to do the right thing automatically.

So I've been dumping all the /sys/class/dmi/id strings on all
Bay Trail and Cherry Trail devices I've (7 different models)
and seeing if anything stands out.

The GPDwin for which I mainly wrote this patch is the only
one to set board_vendor to "AMI Corporation", which is a
string one would usually expect in bios_vendor. So I decided
that we can use normal DMI matching for this after all,
to play things safe I've also added a check for the bios_date
(which should be reasonable unique) + 2 other strings,
resulting in:

+static const struct dmi_system_id fix_up_power_blacklist[] = {
+	{
+		/*
+		 * Match for the GPDwin which unfortunately uses somewhat
+		 * generic dmi strings, which is why the bios-date match is
+		 * included and we need multiple entries :| These strings have
+		 * been checked against 6 other byt/cht boards and board_vendor
+		 * and board_name are unique to the GPDwin (in the test set)
+		 * where as only one other board has the same board_version.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
+			DMI_MATCH(DMI_BOARD_VERSION, "Default string"),
+			DMI_MATCH(DMI_BIOS_DATE, "10/25/2016"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
+			DMI_MATCH(DMI_BOARD_VERSION, "Default string"),
+			DMI_MATCH(DMI_BIOS_DATE, "11/18/2016"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
+			DMI_MATCH(DMI_BOARD_VERSION, "Default string"),
+			DMI_MATCH(DMI_BIOS_DATE, "02/21/2017"),
+		},
+	},
+	{ }
+};

Which is not the prettiest but gets the job done and has the big
advantage over my dmi_product_name kernel cmdline option proposal
that it will just work. So you can consider this patch dropped
from my pov.

Regards,

Hans

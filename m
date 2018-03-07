From: Harish Jenny K N <harish_kandiga@mentor.com>
Subject: Re: [PATCH v6] mmc: Export host capabilities to debugfs.
Date: Wed, 7 Mar 2018 12:34:07 +0530
Message-ID: <af726c5a-edd4-94f9-7789-4527e9aff93d@mentor.com>
References: <1520401051-11135-1-git-send-email-harish_kandiga@mentor.com>
 <DM5PR04MB10857D9F0177C760047100D1FCD80@DM5PR04MB1085.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DM5PR04MB10857D9F0177C760047100D1FCD80@DM5PR04MB1085.namprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Avri Altman <Avri.Altman@wdc.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Vladimir_Zapolskiy@mentor.com" <Vladimir_Zapolskiy@mentor.com>
List-Id: linux-mmc@vger.kernel.org



On Wednesday 07 March 2018 12:10 PM, Avri Altman wrote:
>
>> -----Original Message-----
>> From: Harish Jenny K N [mailto:harish_kandiga@mentor.com]
>> Sent: Wednesday, March 07, 2018 7:38 AM
>> To: ulf.hansson@linaro.org; linus.walleij@linaro.org;
>> adrian.hunter@intel.com; shawn.lin@rock-chips.com; Avri Altman
>> <Avri.Altman@wdc.com>; andriy.shevchenko@linux.intel.com
>> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
>> harish_kandiga@mentor.com; Vladimir_Zapolskiy@mentor.com
>> Subject: [PATCH v6] mmc: Export host capabilities to debugfs.
>>
>> This patch exports the host capabilities to debugfs
>>
>> This idea of sharing host capabilities over debugfs came up from Abbas Raza
>> <Abbas_Raza@mentor.com> Earlier discussions:
>> https://lkml.org/lkml/2018/3/5/357
>> https://www.spinics.net/lists/linux-mmc/msg48219.html
>>
>> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
>> ---
>>
>>
>> +static int mmc_caps_show(struct seq_file *s, void *unused) {
>> +	struct mmc_host *host = s->private;
>> +	u32 caps = host->caps;
>> +
>> +	seq_puts(s, "\nMMC Host capabilities are:\n");
>> +	seq_puts(s,
>> "=============================================\n");
>> +	seq_printf(s, "Can the host do 4 bit transfers :\t%s\n",
>> +		   ((caps & MMC_CAP_4_BIT_DATA) ? "Yes" : "No"));
> Maybe use a more compact form, and just call a macro with the applicable (stringified) bit?

Something like this ?

#define YN(bit) ((caps & bit) ? "Yes" : "No")
and then call
seq_printf(s, "Can the host do 4 bit transfers :\t%s\n", YN(MMC_CAP_4_BIT_DATA));



Thanks,
Harish Jenny K N

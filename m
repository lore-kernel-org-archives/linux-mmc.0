Received: from mail-m21473.qiye.163.com (mail-m21473.qiye.163.com [117.135.214.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F6C4CCDEC
	for <linux-mmc@vger.kernel.org>; Mon,  7 Sep 2026 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788742802; cv=none; b=DCmD1uTJc6jMTXa+6+krEcFLaWjHY16sBIc0kJEfbPUu23FD0ESV8IoDkM0gQQdUrNqpP6SZcChBB91n9vRZMX5b6+aAfnqyRrTjJeZLQFb4PUDdN6tBQ/65N/WRSx6Y/JwDtiNePCNPcNFdXZp5ZBiVFxXjX05ln/SNsTBudh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788742802; c=relaxed/simple;
	bh=9BR7XlgjA9oCEAzYdFV2PiyA99DBegF3/qypWB9qHxk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tA/K1ErKcjsqw0jXb7nU8ee7S7Dir5OJyWBF3zCdH2FIxryEpHXrY5RycKJxUYpc+a9+yjXlGQKq0rlTuqX8S4B39FDGa1ZvqsKpi1tT/S8r2AWU6Im475gqQfjyC2awp/GN19nGjNuyIbzYRJoHTgDRgHz0r/gtX3mK2OefOAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gUMxgrCy; arc=none smtp.client-ip=117.135.214.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gUMxgrCy"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4cb849b95;
	Mon, 7 Sep 2026 08:44:29 +0800 (GMT+08:00)
Message-ID: <50dc2445-2483-485b-aab4-5e56fdc0a166@rock-chips.com>
Date: Mon, 7 Sep 2026 08:44:26 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Shawn Lin <shawn.lin@linux.dev>
Subject: Re: [PATCH] mmc-utils: Add health command for eMMC health reporting
To: Avri Altman <Avri.Altman@sandisk.com>, Ulf Hansson <ulfh@kernel.org>
References: <1788525214-40803-1-git-send-email-shawn.lin@rock-chips.com>
 <DS1PR16MB6753DA98DCC26E114D325284E5B42@DS1PR16MB6753.namprd16.prod.outlook.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <DS1PR16MB6753DA98DCC26E114D325284E5B42@DS1PR16MB6753.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa07952e0cf03a4kunmd5fe00832cc131
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSktCVh9NGR1CSENNHRoZQ1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=gUMxgrCyOqxXVZqkbfwDsJKjRjjqSZeE5PIPVl5G2q4BdehwWt3Ywqq8PqOujsXF8KbS0UVHgV8X5luyjcxddtCOTLL+x7TCc6cqat5xISiTa1uRQeDmaYX6YgZTq8QPdyydtWt7Ff7ow4d4ZStYn/o1iFnucCguwv9F/pzIHWA=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=dF1zS8nc73R790NjSYBixElrLYncFu9NUfxh5ENwewE=;
	h=date:mime-version:subject:message-id:from;

Hi Avri

在 2026/09/05 星期六 19:32, Avri Altman 写道:
>> From: Shawn Lin <shawn.lin@linux.dev>
>>
>> Add a "mmc health <device>" command that prints a health summary of an
>> eMMC device: Pre EOL info, device life time estimates (type A and B) and BKOPS
>> status, each with a human readable decode of the raw field, plus a final verdict
>> line.
>>
>> The per-field values and their level semantics come from the eMMC 5.0 spec
>> (JESD84-B50, EXT_CSD fields 267/268/269/33); the aggregated verdict takes the
>> worst of the three wear related fields and maps it onto an exit code, so the
>> command can be used directly from production test scripts and CI:
>>
>>    0 healthy, 1 warning, 2 urgent, 3 unsupported (eMMC < 5.0),
>>    4 not an eMMC device (EXT_CSD read failed).
> If you are inventing a device health measure, better make sure to clearly indicate that this is mmc-utils's own indicator.
> Also, worth mentioning VENDOR_PROPRIETARY_HEALTH_REPORT [301-270], and CMD56 in the commit log.
> 

Sure, will do.

>>
>> The command is eMMC only: SD cards do not have EXT_CSD and do not report
>> any standardized health data.
>>
>> Execution effect on an eMMC 5.1 device:
>>
>>    # mmc health /dev/block/mmcblk0
>>    =============================================
>>      eMMC Health Report: /dev/block/mmcblk0
>>    =============================================
>>    eMMC rev:         1.8 (MMC 5.1)
>>    Pre EOL info:     0x01 [Normal]
>>    Life time type A: 0x01 [0%-10% of device life time used]
>>    Life time type B: 0x01 [0%-10% of device life time used]
>>    BKOPS status:     0x01 [Level 1: background operation required (non-urgent)]
>>    Result: HEALTHY
>>
>> Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
>> ---
>>   mmc.c      |   8 +++
>>   mmc.h      |   1 +
>>   mmc_cmds.c | 165
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   mmc_cmds.h |   1 +
>>   4 files changed, 175 insertions(+)
>>
>> diff --git a/mmc.c b/mmc.c
>> index b0f1f9b..e0fc0e8 100644
>> --- a/mmc.c
>> +++ b/mmc.c
>> @@ -106,6 +106,14 @@ static struct Command commands[] = {
>>            "status get", "<device>\n"
>>            "Print the response to STATUS_SEND (CMD13).",
>>          },
>> +       { do_health, -1,
>> +         "health", "<device>\n"
>> +         "Print a health summary of the eMMC <device>: Pre EOL info,\n"
>> +         "device life time estimates and BKOPS status. eMMC only, SD\n"
>> +         "cards do not report health data.\n"
>> +         "Exit code: 0 healthy, 1 warning, 2 urgent, 3 unsupported\n"
>> +         "(eMMC < 5.0), 4 not an eMMC device.",
>> +       },
>>          { do_write_boot_en, -3,
>>            "bootpart enable", "<boot_partition> " "<send_ack> " "<device>\n"
>>                  "Enable the boot partition for the <device>.\nDisable the boot partition
>> for the <device> if <boot_partition> is set to 0.\nTo receive acknowledgment of
>> boot from the card set <send_ack>\nto 1, else set it to 0.", diff --git a/mmc.h
>> b/mmc.h index 2bb346b..af0ad87 100644
>> --- a/mmc.h
>> +++ b/mmc.h
>> @@ -120,6 +120,7 @@
>>   #define EXT_CSD_WR_REL_SET             167
>>   #define EXT_CSD_WR_REL_PARAM           166
>>   #define EXT_CSD_SANITIZE_START         165
>> +#define EXT_CSD_BKOPS_STATUS           33      /* RO */
> BKOPS_STATUS [246]
> 
>>   #define EXT_CSD_BKOPS_EN               163     /* R/W */
>>   #define EXT_CSD_RST_N_FUNCTION         162     /* R/W */
>>   #define EXT_CSD_PARTITIONING_SUPPORT   160     /* RO */
>> diff --git a/mmc_cmds.c b/mmc_cmds.c
>> index a7e4784..43dcdcc 100644
>> --- a/mmc_cmds.c
>> +++ b/mmc_cmds.c
>> @@ -981,6 +981,171 @@ out_free:
>>          return ret;
>>   }
>>
>> +static const char *extcsd_rev_to_string(__u8 rev) {
> Already in do_read_extcsd, maybe factor it out (as a preparatory patch) ?
> 

Make sense.

>> +       switch (rev) {
>> +       case 9:
>> +       case 8:
>> +               return "5.1";
>> +       case 7:
>> +               return "5.0";
>> +       case 6:
>> +               return "4.5";
>> +       case 5:
>> +               return "4.41";
>> +       case 3:
>> +               return "4.3";
>> +       case 2:
>> +               return "4.2";
>> +       case 1:
>> +               return "4.1";
>> +       case 0:
>> +               return "4.0";
>> +       default:
>> +               return "unknown";
>> +       }
>> +}
>> +
>> +static const char *pre_eol_info_to_string(__u8 val) {
>> +       switch (val) {
>> +       case 0x00:
>> +               return "Not defined";
>> +       case 0x01:
>> +               return "Normal";
>> +       case 0x02:
>> +               return "Warning: reserved blocks are consumed";
> Consumed 80% of reserved block
> 
>> +       case 0x03:
>> +               return "Urgent: reserved blocks are exhausted";
> The spec gives no description at all for 0x03 aside of urgent.
> 

Will fix.

>> +       default:
>> +               return "Reserved";
>> +       }
>> +}
>> +
>> +static const char *life_time_est_to_string(__u8 val) {
>> +       static const char * const strs[] = {
>> +               "Not defined",                                     /* 0x00 */
>> +               "0%-10% of device life time used",                 /* 0x01 */
>> +               "10%-20% of device life time used",                /* 0x02 */
>> +               "20%-30% of device life time used",                /* 0x03 */
>> +               "30%-40% of device life time used",                /* 0x04 */
>> +               "40%-50% of device life time used",                /* 0x05 */
>> +               "50%-60% of device life time used",                /* 0x06 */
>> +               "60%-70% of device life time used",                /* 0x07 */
>> +               "70%-80% of device life time used",                /* 0x08 */
>> +               "80%-90% of device life time used",                /* 0x09 */
>> +               "90%-100% of device life time used",               /* 0x0A */
>> +               "Exceeded the maximum estimated device life time", /* 0x0B */
>> +       };
>> +
>> +       if (val > 0x0B)
>> +               return "Reserved";
>> +
>> +       return strs[val];
>> +}
>> +
>> +static const char *bkops_status_to_string(__u8 val) {
>> +       switch (val) {
>> +       case 0x00:
>> +               return "No background operation required";
>> +       case 0x01:
>> +               return "Level 1: background operation required (non-urgent)";
>> +       case 0x02:
>> +               return "Level 2: background operation required (performance
>> impacted)";
>> +       case 0x03:
>> +               return "Level 3: background operation required (urgent)";
>> +       default:
>> +               return "Reserved";
>> +       }
>> +}
>> +
>> +/*
>> + * Print a health summary of the device. Exit codes:
>> + *   0 healthy (or no degradation reported)
>> + *   1 warning level
>> + *   2 urgent level
>> + *   3 health data not supported (eMMC < 5.0)
>> + *   4 not an eMMC device (EXT_CSD read failed)
>> + * Only meaningful for eMMC; SD cards do not report health data.
>> + */
>> +int do_health(int nargs, char **argv)
>> +{
>> +       __u8 ext_csd[512], ext_csd_rev, pre_eol, life_typ_a, life_typ_b, bkops;
>> +       int fd, ret;
>> +       char *device;
>> +
>> +       if (nargs != 2) {
>> +               print_usage(do_health);
>> +               exit(1);
>> +       }
>> +
>> +       device = argv[1];
>> +
>> +       fd = open(device, O_RDWR);
>> +       if (fd < 0) {
>> +               perror("open");
>> +               exit(1);
>> +       }
>> +
>> +       ret = read_extcsd(fd, ext_csd);
>> +       if (ret) {
>> +               fprintf(stderr, "Could not read EXT_CSD from %s, "
>> +                               "not an eMMC device?\n", device);
>> +               close(fd);
>> +               exit(4);
>> +       }
>> +
>> +       ext_csd_rev = ext_csd[EXT_CSD_REV];
>> +       pre_eol = ext_csd[EXT_CSD_PRE_EOL_INFO];
>> +       life_typ_a = ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A];
>> +       life_typ_b = ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B];
>> +       bkops = ext_csd[EXT_CSD_BKOPS_STATUS];
> only bits [1:0] are defined, better mask?  ext_csd[EXT_CSD_BKOPS_STATUS] & 3
> 

Sure.

>> +
>> +       printf("=============================================\n");
>> +       printf("  eMMC Health Report: %s\n", device);
>> +       printf("=============================================\n");
>> +       printf("eMMC rev:         1.%d (MMC %s)\n", ext_csd_rev,
>> +              extcsd_rev_to_string(ext_csd_rev));
> eMMC rev:  --> Extended CSD rev
> 
>> +       printf("Pre EOL info:     0x%02x [%s]\n", pre_eol,
>> +              pre_eol_info_to_string(pre_eol));
>> +       printf("Life time type A: 0x%02x [%s]\n", life_typ_a,
>> +              life_time_est_to_string(life_typ_a));
>> +       printf("Life time type B: 0x%02x [%s]\n", life_typ_b,
>> +              life_time_est_to_string(life_typ_b));
>> +       printf("BKOPS status:     0x%02x [%s]\n", bkops,
>> +              bkops_status_to_string(bkops));
>> +
>> +       if (ext_csd_rev < 7) {
> EXT_CSD_REV_V5_0
> 

Ack.


>> +               printf("Result: UNSUPPORTED (health data requires eMMC 5.0)\n");
> But you already printed the health fields...
> 
>> +               ret = 3;
>> +               goto out;
>> +       }
>> +
>> +       if (pre_eol == 0x03 || life_typ_a == 0x0B || life_typ_b == 0x0B) {
>> +               printf("Result: URGENT\n");
>> +               ret = 2;
>> +       } else if (pre_eol == 0x02 || life_typ_a == 0x0A ||
>> +                  life_typ_b == 0x0A) {
>> +               printf("Result: WARNING\n");
>> +               ret = 1;
> Collides with exit(1).
> So what it would be: "the device has a wear warning" or "the command failed" ?
> 

Good catch, will fix.

> Thanks,
> Avri
>> +       } else if (pre_eol == 0x00 && life_typ_a == 0x00 &&
>> +                  life_typ_b == 0x00) {
>> +               printf("Result: UNKNOWN (device does not report health data)\n");
>> +       } else {
>> +               printf("Result: HEALTHY\n");
>> +       }
>> +
>> +       if (bkops == 0x03)
>> +               printf("Note: urgent background operation is pending, "
>> +                      "do not power off the device right now\n");
>> +
>> +out:
>> +       close(fd);
>> +       return ret;
>> +}
>> +
>>   static unsigned int get_sector_count(__u8 *ext_csd)  {
>>          return (ext_csd[EXT_CSD_SEC_COUNT_3] << 24) | diff --git a/mmc_cmds.h
>> b/mmc_cmds.h index 033cc09..88caf85 100644
>> --- a/mmc_cmds.h
>> +++ b/mmc_cmds.h
>> @@ -39,6 +39,7 @@ int do_hwreset_en(int nargs, char **argv);  int
>> do_hwreset_dis(int nargs, char **argv);  int do_sanitize(int nargs, char **argv);
>> int do_status_get(int nargs, char **argv);
>> +int do_health(int nargs, char **argv);
>>   int do_create_gp_partition(int nargs, char **argv);  int do_enh_area_set(int
>> nargs, char **argv);  int do_write_reliability_set(int nargs, char **argv);
>> --
>> 2.25.1
> 
> 


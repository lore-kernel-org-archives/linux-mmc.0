Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D54CC433B4
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Apr 2021 07:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B5D6145A
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Apr 2021 07:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhDVHjS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Apr 2021 03:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhDVHjR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Apr 2021 03:39:17 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35832C06138B
        for <linux-mmc@vger.kernel.org>; Thu, 22 Apr 2021 00:38:43 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id i9so7541332vsb.13
        for <linux-mmc@vger.kernel.org>; Thu, 22 Apr 2021 00:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QoKl71Li0Bz0ZD2/nBKflS/ASMbh0VdJWQqVRao6Obo=;
        b=h7zd4GEFDXIPB+rOqDQNR06iDhRrtXI1pIRnizhl7TVXTAgKHwaB3R4pV6JO8VPYyk
         kcGVkSD1gWGQDKCES3AJ2ieLb1hL7XWw+Kx7zD37Oi0nfJvh0YnGkV4K0BNRkmkpIz/h
         w4dg7ecYYxBmC9kZ4zQb3xLWMSSx5M5HirKf5bkXLeZU5XPyCH4cg7KLN6QfWWckYXlm
         UdiRChrENbgq0xiPoxC/vg4TExIOthCY68oPAYB37Xwh1MCj9WhdQLODwUhTyCUvQA/5
         YJ0Rq/2OykwlGH+ZXY5AcniPl+cTr7Q9AhsgMDNXwhcmAU30rSFIZUlv8/dGE72cDGNz
         kMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QoKl71Li0Bz0ZD2/nBKflS/ASMbh0VdJWQqVRao6Obo=;
        b=UcT8M7CVLERRIih0whuweEVvdnY3w8cZfxQH16KUR1CHmY5GMBtzfhtHTSosNfSLBE
         mZFtGwOIPp3om8M3sZ7IEICvCL6tVbV/knCsRaiCOLKS+fxl+VQxr6M/uWNZPSoc3mOy
         t2nxghmoPSEPXzHEZDyVv80JlxdpFSvbYCyIVQpVC9VId9GxrTQw10cd4t83lHZ+81Rp
         kzbTghyH3U1MVLdAWLJGAOuBNY9pAGSCVN+EG/6Vls6G1eBk/xgatkKPGqBTzHkjnGS9
         03RRy2AlJU/aqzoPTldCgVVKoMV6yYmBujZ8fz96aJ3dsU8Df5Q4Hud5JVAXb35bMvmX
         znrQ==
X-Gm-Message-State: AOAM531d0OtLuVgCaWLzrtnQVl6LE5o62PTM88e159FDZtCRgh0LfGX1
        rSIpdI4Qs+rXp2kP93D+sWf/FEp8uGiLsaWiY0Jw5A==
X-Google-Smtp-Source: ABdhPJykrcQAwPtxswOnUByrKTzk5eE0Cjeqp+ejzmMZ3WrFuwSmJFM5e2D0bmWqNGtEBrkLCuKVRa1drGSxraRyLOE=
X-Received: by 2002:a67:e902:: with SMTP id c2mr1255118vso.42.1619077122287;
 Thu, 22 Apr 2021 00:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210401230221.12532-1-luserhker@gmail.com> <CAPDyKFpjTikAzDqkcbyxa1Y918OevojZYhREPsmQgeo_Sd0xgA@mail.gmail.com>
 <7bca3bca-b058-7086-b733-359c21e3d473@oracle.com> <7842f17c-7d8b-481a-1f84-c80de715be0d@oracle.com>
 <55316844-d13f-bb84-a269-98f8cb649016@oracle.com>
In-Reply-To: <55316844-d13f-bb84-a269-98f8cb649016@oracle.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Apr 2021 09:38:06 +0200
Message-ID: <CAPDyKFqwztxA7yWBhUpqgd=oHyBS5L-gu77y-R8TdfJPnisVwA@mail.gmail.com>
Subject: Re: [External] : Re: [PATCH v3] Re-submit of the erase command
 addition plus removal of MMC_IOC_MULTI_CMD ifndef for erase. Author=Kimito
 Sakata <kimito.sakata@oracle.com>
To:     kimito.sakata@oracle.com
Cc:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        kenny.gibbons@oracle.com, rkamdar@micron.com,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kimito Sakata <ksakata@kimitos-mbp.hsd1.co.comcast.net>,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 21 Apr 2021 at 20:39, <kimito.sakata@oracle.com> wrote:
>
> Ulf
>
> Looks like Avri either has no comments or cannot respond. Could we
> please go ahead with the changes?

I think we should give him a couple more days, it's not been more than
just a week since I looped him in to review the patch.

Another option, that might be easier for him, is if you repost the
patch and make sure Avri is on the to-list, this time.

Kind regards
Uffe

>
> Thanks
> Kimito
>
> On 4/20/2021 11:22 AM, kimito.sakata@oracle.com wrote:
> > Avri
> >
> > I'm sure you are very busy, but I would appreciate if you have any
> > concerns on these changes that I submitted.
> >
> > Thanks
> > Kimito
> >
> >
> > On 4/15/2021 2:11 PM, kimito.sakata@oracle.com wrote:
> >> Avri
> >>
> >> Please let me know if you have some concerns.
> >>
> >> Kimito
> >>
> >> On 4/15/2021 6:32 AM, Ulf Hansson wrote:
> >>> + Avri
> >>>
> >>> On Fri, 2 Apr 2021 at 01:02, <luserhker@gmail.com> wrote:
> >>>> From: Kimito Sakata <kimito.sakata@oracle.com>
> >>>>
> >>>> Signed-off-by: Kimito Sakata <ksakata@Kimitos-MBP.hsd1.co.comcast.net>
> >>> This looks okay to me, but I have looped in Avri who might have some
> >>> comments.
> >>>
> >>> Kind regards
> >>> Uffe
> >>>
> >>>> ---
> >>>>   mmc.c      |   8 ++++
> >>>>   mmc.h      |  13 +++++-
> >>>>   mmc_cmds.c | 129
> >>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>>>   mmc_cmds.h |   1 +
> >>>>   4 files changed, 150 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/mmc.c b/mmc.c
> >>>> index f3d724b..eb2638b 100644
> >>>> --- a/mmc.c
> >>>> +++ b/mmc.c
> >>>> @@ -229,6 +229,14 @@ static struct Command commands[] = {
> >>>>                  "Run Field Firmware Update with <image name> on
> >>>> <device>.\n",
> >>>>            NULL
> >>>>          },
> >>>> +       { do_erase, -4,
> >>>> +       "erase", "<type> " "<start address> " "<end address> "
> >>>> "<device>\n"
> >>>> +               "Send Erase CMD38 with specific argument to the
> >>>> <device>\n\n"
> >>>> +               "NOTE!: This will delete all user data in the
> >>>> specified region of the device\n"
> >>>> +               "<type> must be: legacy | discard | secure-erase | "
> >>>> +               "secure-trim1 | secure-trim2 | trim \n",
> >>>> +       NULL
> >>>> +       },
> >>>>          { 0, 0, 0, 0 }
> >>>>   };
> >>>>
> >>>> diff --git a/mmc.h b/mmc.h
> >>>> index 5754a9d..e9766d7 100644
> >>>> --- a/mmc.h
> >>>> +++ b/mmc.h
> >>>> @@ -35,7 +35,15 @@
> >>>>   #define MMC_SET_WRITE_PROT     28    /* ac   [31:0] data addr
> >>>> R1b */
> >>>>   #define MMC_CLEAR_WRITE_PROT   29    /* ac   [31:0] data addr
> >>>> R1b */
> >>>>   #define MMC_SEND_WRITE_PROT_TYPE 31   /* ac   [31:0] data addr
> >>>> R1  */
> >>>> -
> >>>> +#define MMC_ERASE_GROUP_START  35    /* ac   [31:0] data addr
> >>>> R1  */
> >>>> +#define MMC_ERASE_GROUP_END    36    /* ac   [31:0] data addr
> >>>> R1  */
> >>>> +#define MMC_ERASE              38    /* ac   [31] Secure request
> >>>> +                                             [30:16] set to 0
> >>>> +                                             [15] Force Garbage
> >>>> Collect request
> >>>> +                                             [14:2] set to 0
> >>>> +                                             [1] Discard Enable
> >>>> +                                             [0] Identify Write
> >>>> Blocks for
> >>>> +                                             Erase (or TRIM
> >>>> Enable)  R1b */
> >>>>   /*
> >>>>    * EXT_CSD fields
> >>>>    */
> >>>> @@ -62,6 +70,7 @@
> >>>>   #define EXT_CSD_CACHE_SIZE_2           251
> >>>>   #define EXT_CSD_CACHE_SIZE_1           250
> >>>>   #define EXT_CSD_CACHE_SIZE_0           249
> >>>> +#define EXT_CSD_SEC_FEATURE_SUPPORT    231
> >>>>   #define EXT_CSD_BOOT_INFO              228     /* R/W */
> >>>>   #define EXT_CSD_HC_ERASE_GRP_SIZE      224
> >>>>   #define EXT_CSD_HC_WP_GRP_SIZE         221
> >>>> @@ -190,6 +199,8 @@
> >>>>   #define EXT_CSD_REV_V4_2               2
> >>>>   #define EXT_CSD_REV_V4_1               1
> >>>>   #define EXT_CSD_REV_V4_0               0
> >>>> +#define EXT_CSD_SEC_GB_CL_EN           (1<<4)
> >>>> +#define EXT_CSD_SEC_ER_EN              (1<<0)
> >>>>
> >>>>
> >>>>   /* From kernel linux/mmc/core.h */
> >>>> diff --git a/mmc_cmds.c b/mmc_cmds.c
> >>>> index 6c24cea..3e36ff2 100644
> >>>> --- a/mmc_cmds.c
> >>>> +++ b/mmc_cmds.c
> >>>> @@ -2514,6 +2514,135 @@ int do_cache_dis(int nargs, char **argv)
> >>>>          return do_cache_ctrl(0, nargs, argv);
> >>>>   }
> >>>>
> >>>> +static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
> >>>> +{
> >>>> +       int ret = 0;
> >>>> +       struct mmc_ioc_multi_cmd *multi_cmd;
> >>>> +
> >>>> +       multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
> >>>> +                          3 * sizeof(struct mmc_ioc_cmd));
> >>>> +       if (!multi_cmd) {
> >>>> +               perror("Failed to allocate memory");
> >>>> +               return -ENOMEM;
> >>>> +       }
> >>>> +
> >>>> +       multi_cmd->num_of_cmds = 3;
> >>>> +       /* Set erase start address */
> >>>> +       multi_cmd->cmds[0].opcode = MMC_ERASE_GROUP_START;
> >>>> +       multi_cmd->cmds[0].arg = start;
> >>>> +       multi_cmd->cmds[0].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> >>>> MMC_CMD_AC;
> >>>> +       multi_cmd->cmds[0].write_flag = 1;
> >>>> +
> >>>> +       /* Set erase end address */
> >>>> +       multi_cmd->cmds[1].opcode = MMC_ERASE_GROUP_END;
> >>>> +       multi_cmd->cmds[1].arg = end;
> >>>> +       multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> >>>> MMC_CMD_AC;
> >>>> +       multi_cmd->cmds[1].write_flag = 1;
> >>>> +
> >>>> +       /* Send Erase Command */
> >>>> +       multi_cmd->cmds[2].opcode = MMC_ERASE;
> >>>> +       multi_cmd->cmds[2].arg = argin;
> >>>> +       multi_cmd->cmds[2].cmd_timeout_ms = 300*255*255;
> >>>> +       multi_cmd->cmds[2].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B |
> >>>> MMC_CMD_AC;
> >>>> +       multi_cmd->cmds[2].write_flag = 1;
> >>>> +
> >>>> +       /* send erase cmd with multi-cmd */
> >>>> +       ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> >>>> +       if (ret)
> >>>> +               perror("Erase multi-cmd ioctl");
> >>>> +
> >>>> +       free(multi_cmd);
> >>>> +       return ret;
> >>>> +}
> >>>> +
> >>>> +int do_erase(int nargs, char **argv)
> >>>> +{
> >>>> +       int dev_fd, ret;
> >>>> +       char *print_str;
> >>>> +       char **eptr = NULL;
> >>>> +       __u8 ext_csd[512], checkup_mask = 0;
> >>>> +       __u32 arg, start, end;
> >>>> +
> >>>> +       if (nargs != 5) {
> >>>> +               fprintf(stderr, "Usage: erase <type> <start addr>
> >>>> <end addr> </path/to/mmcblkX>\n");
> >>>> +               exit(1);
> >>>> +       }
> >>>> +
> >>>> +       if (strstr(argv[2], "0x") || strstr(argv[2], "0X"))
> >>>> +               start = strtol(argv[2], eptr, 16);
> >>>> +       else
> >>>> +               start = strtol(argv[2], eptr, 10);
> >>>> +
> >>>> +       if (strstr(argv[3], "0x") || strstr(argv[3], "0X"))
> >>>> +               end = strtol(argv[3], eptr, 16);
> >>>> +       else
> >>>> +               end = strtol(argv[3], eptr, 10);
> >>>> +
> >>>> +       if (end < start) {
> >>>> +               fprintf(stderr, "erase start [0x%08x] > erase end
> >>>> [0x%08x]\n",
> >>>> +                       start, end);
> >>>> +               exit(1);
> >>>> +       }
> >>>> +
> >>>> +       if (strcmp(argv[1], "legacy") == 0) {
> >>>> +               arg = 0x00000000;
> >>>> +               print_str = "Legacy Erase";
> >>>> +       } else if (strcmp(argv[1], "discard") == 0) {
> >>>> +               arg = 0x00000003;
> >>>> +               print_str = "Discard";
> >>>> +       } else if (strcmp(argv[1], "secure-erase") == 0) {
> >>>> +               print_str = "Secure Erase";
> >>>> +               checkup_mask = EXT_CSD_SEC_ER_EN;
> >>>> +               arg = 0x80000000;
> >>>> +       } else if (strcmp(argv[1], "secure-trim1") == 0) {
> >>>> +               print_str = "Secure Trim Step 1";
> >>>> +               checkup_mask = EXT_CSD_SEC_ER_EN |
> >>>> EXT_CSD_SEC_GB_CL_EN;
> >>>> +               arg = 0x80000001;
> >>>> +       } else if (strcmp(argv[1], "secure-trim2") == 0) {
> >>>> +               print_str = "Secure Trim Step 2";
> >>>> +               checkup_mask = EXT_CSD_SEC_ER_EN |
> >>>> EXT_CSD_SEC_GB_CL_EN;
> >>>> +               arg = 0x80008000;
> >>>> +       } else if (strcmp(argv[1], "trim") == 0) {
> >>>> +               print_str = "Trim";
> >>>> +               checkup_mask = EXT_CSD_SEC_GB_CL_EN;
> >>>> +               arg = 0x00000001;
> >>>> +       } else {
> >>>> +               fprintf(stderr, "Unknown erase type: %s\n", argv[1]);
> >>>> +               exit(1);
> >>>> +       }
> >>>> +
> >>>> +       dev_fd = open(argv[4], O_RDWR);
> >>>> +       if (dev_fd < 0) {
> >>>> +               perror(argv[4]);
> >>>> +               exit(1);
> >>>> +       }
> >>>> +
> >>>> +       if (checkup_mask) {
> >>>> +               ret = read_extcsd(dev_fd, ext_csd);
> >>>> +               if (ret) {
> >>>> +                       fprintf(stderr, "Could not read EXT_CSD
> >>>> from %s\n",
> >>>> +                               argv[4]);
> >>>> +                       goto out;
> >>>> +               }
> >>>> +               if ((checkup_mask &
> >>>> ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT]) !=
> >>>> + checkup_mask) {
> >>>> +                       fprintf(stderr, "%s is not supported in %s\n",
> >>>> +                               print_str, argv[4]);
> >>>> +                       ret = -ENOTSUP;
> >>>> +                       goto out;
> >>>> +               }
> >>>> +
> >>>> +       }
> >>>> +       printf("Executing %s from 0x%08x to 0x%08x\n", print_str,
> >>>> start, end);
> >>>> +
> >>>> +       ret = erase(dev_fd, arg, start, end);
> >>>> +out:
> >>>> +       printf(" %s %s!\n\n", print_str, ret ? "Failed" : "Succeed");
> >>>> +       close(dev_fd);
> >>>> +       return ret;
> >>>> +}
> >>>> +
> >>>> +
> >>>>   int do_ffu(int nargs, char **argv)
> >>>>   {
> >>>>   #ifndef MMC_IOC_MULTI_CMD
> >>>> diff --git a/mmc_cmds.h b/mmc_cmds.h
> >>>> index 9d3246c..8331ab2 100644
> >>>> --- a/mmc_cmds.h
> >>>> +++ b/mmc_cmds.h
> >>>> @@ -45,3 +45,4 @@ int do_ffu(int nargs, char **argv);
> >>>>   int do_read_scr(int argc, char **argv);
> >>>>   int do_read_cid(int argc, char **argv);
> >>>>   int do_read_csd(int argc, char **argv);
> >>>> +int do_erase(int nargs, char **argv);
> >>>> --
> >>>> 2.24.1 (Apple Git-126)
> >>>>
> >>
> >
>

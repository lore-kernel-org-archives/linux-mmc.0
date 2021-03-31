Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C872EC433E2
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 09:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91F30619EB
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 09:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhCaJlg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 Mar 2021 05:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbhCaJlX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Mar 2021 05:41:23 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B59EC061574
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 02:41:21 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id v29so5608739vsi.7
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 02:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SPh0AGXbXZFucwmbv4zBXH/STcwrFAAMylcFch3tFfo=;
        b=hBfZ7V+qkKroUrsGFUFg9AbCNKzPnJM/5UAXsHLM4hd7j4so9j91fO+/cRGiwLU7uU
         INgjkD/qgGoaNM3pEJ5i69/J0XWyPoRqkyJn0G8UAZ1/MvHM1vvKndLMhIclkpL4tqis
         ynqRNZsPivElm/i135Ae8cACi7aYiqI5lh4FNM14aAfeSWeXUKqotVnAIQIVG3vZ/k7w
         x6ueQ567klZqKv7SviVGWWSigJgfCEp0LUQdDkcT6P0tbGPQSG4lgJ09m2s2TQ5WcELf
         EgQ0SAKNKIV03JH+qJ7VPJw10+rnA/BhEimfYTG9ywrhMlFUtT14Ei8teWg/y/r8QcTN
         YFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SPh0AGXbXZFucwmbv4zBXH/STcwrFAAMylcFch3tFfo=;
        b=FfZmvZlZjDxlqfPcWHqOIYkhDQ6L1nQ7CIa3ed8yrtbio7mIiXHcSnCRyx81tkI/lu
         wltw+PRAP4pa9bBlQqQAlqPtrsukdL21aKOf1/oQ/maPHk1uXEi1DnqfeJqJsv6IJiVU
         +8QN+ffOOdL++sJfqZQZb9lp20rvn4IgIgqgrBIysYtXQF2Vbu/6C80C/J2CSvaHAoic
         q3gTmCpNizNnjkZumtYCrqG5sGEBjAsCLASqLxhet3TuvXGiQe2Q6rGR8I5AsJLKlqVe
         VRSP7ayylC6RBmn8N5uhEL6yXATO218OwBxdPoqFYa8Ar7ngwqncfZus2doUFCekoJfZ
         bj4Q==
X-Gm-Message-State: AOAM533GxUHbOAAzYS7gBoD7QzlhJpNXBX56R0xNiZS3L8y9a7lzGDH1
        EiF13wegn7k4vNC3e1IBsTRi/cEW+EaRNkU/Y5trADMHEfK2SA==
X-Google-Smtp-Source: ABdhPJxiH1oCc2trzAAfrR0vM6qfX6Duhs0bqeN1ZUr+dtvRwtBuxNDCm9qOrj+JAOHE04XdtIRvrFw7sRDBWrpflAM=
X-Received: by 2002:a67:8c89:: with SMTP id o131mr860247vsd.42.1617183680734;
 Wed, 31 Mar 2021 02:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200316202221.107714-1-jwerner@chromium.org>
In-Reply-To: <20200316202221.107714-1-jwerner@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 31 Mar 2021 11:40:43 +0200
Message-ID: <CAPDyKFqSHK-pZB4Hwq2eGeVkXqxY4pZUjY-fo50WHrmZQMqSPA@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: Expand 'writeprotect boot'
To:     Julius Werner <jwerner@chromium.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Avri

On Mon, 16 Mar 2020 at 21:22, Julius Werner <jwerner@chromium.org> wrote:
>
> This patch updates 'mmc writeprotect boot set' with a few more optional
> parameters, so that it can be used to enable permanent write-protection
> and so that the two boot partitions can be protected independently. It
> also splits protection information output by 'mmc writeprotect boot get'
> by partition.
>
> (Note: eMMC boot partitions are named "Area 1" and "Area 2" by the eMMC
> spec, but mmcblk0boot0 and mmcblk0boot1 by Linux. To avoid confusion
> between the two numbering schemes, this patch uses 0 and 1 throughout,
> even when defining EXT_CSD register bits.)
>
> Signed-off-by: Julius Werner <jwerner@chromium.org>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
>  mmc.c      | 17 ++++++++++---
>  mmc.h      | 11 ++++++++
>  mmc_cmds.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++------
>  3 files changed, 91 insertions(+), 11 deletions(-)
>
> diff --git a/mmc.c b/mmc.c
> index 50c9c9e..9e46072 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -64,9 +64,20 @@ static struct Command commands[] = {
>           NULL
>         },
>         { do_writeprotect_boot_set, -1,
> -         "writeprotect boot set", "<device>\n"
> -               "Set the boot partitions write protect status for <device>.\nThis sets the eMMC boot partitions to be write-protected until\nthe next boot.",
> -         NULL
> +         "writeprotect boot set",
> +#ifdef DANGEROUS_COMMANDS_ENABLED
> +               "[-p] "
> +#endif /* DANGEROUS_COMMANDS_ENABLED */
> +               "<device> [<number>]\n"
> +               "Set the boot partition write protect status for <device>.\n"
> +               "If <number> is passed (0 or 1), only protect that particular\n"
> +               "eMMC boot partition, otherwise protect both. It will be\n"
> +               "write-protected until the next boot.\n"
> +#ifdef DANGEROUS_COMMANDS_ENABLED
> +               "  -p  Protect partition permanently instead.\n"
> +               "      NOTE! -p is a one-time programmable (unreversible) change.\n"
> +#endif /* DANGEROUS_COMMANDS_ENABLED */
> +         , NULL
>         },
>         { do_writeprotect_user_set, -4,
>           "writeprotect user set", "<type>" "<start block>" "<blocks>" "<device>\n"
> diff --git a/mmc.h b/mmc.h
> index 648fb26..e3cb621 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -74,6 +74,7 @@
>  #define EXT_CSD_PART_CONFIG            179
>  #define EXT_CSD_BOOT_BUS_CONDITIONS    177
>  #define EXT_CSD_ERASE_GROUP_DEF                175
> +#define EXT_CSD_BOOT_WP_STATUS         174
>  #define EXT_CSD_BOOT_WP                        173
>  #define EXT_CSD_USER_WP                        171
>  #define EXT_CSD_FW_CONFIG              169     /* R/W */
> @@ -143,9 +144,19 @@
>  #define EXT_CSD_HPI_SUPP               (1<<0)
>  #define EXT_CSD_HPI_IMPL               (1<<1)
>  #define EXT_CSD_CMD_SET_NORMAL         (1<<0)
> +/* NOTE: The eMMC spec calls the partitions "Area 1" and "Area 2", but Linux
> + * calls them mmcblk0boot0 and mmcblk0boot1. To avoid confustion between the two
> + * numbering schemes, this tool uses 0 and 1 throughout. */
> +#define EXT_CSD_BOOT_WP_S_AREA_1_PERM  (0x08)
> +#define EXT_CSD_BOOT_WP_S_AREA_1_PWR   (0x04)
> +#define EXT_CSD_BOOT_WP_S_AREA_0_PERM  (0x02)
> +#define EXT_CSD_BOOT_WP_S_AREA_0_PWR   (0x01)
> +#define EXT_CSD_BOOT_WP_B_SEC_WP_SEL   (0x80)
>  #define EXT_CSD_BOOT_WP_B_PWR_WP_DIS   (0x40)
>  #define EXT_CSD_BOOT_WP_B_PERM_WP_DIS  (0x10)
> +#define EXT_CSD_BOOT_WP_B_PERM_WP_SEC_SEL (0x08)
>  #define EXT_CSD_BOOT_WP_B_PERM_WP_EN   (0x04)
> +#define EXT_CSD_BOOT_WP_B_PWR_WP_SEC_SEL (0x02)
>  #define EXT_CSD_BOOT_WP_B_PWR_WP_EN    (0x01)
>  #define EXT_CSD_BOOT_INFO_HS_MODE      (1<<2)
>  #define EXT_CSD_BOOT_INFO_DDR_DDR      (1<<1)
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index fb37189..c230127 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -202,11 +202,19 @@ static void print_writeprotect_boot_status(__u8 *ext_csd)
>                 else
>                         printf("possible\n");
>
> -               printf(" ro lock status: ");
> -               if (reg & EXT_CSD_BOOT_WP_B_PWR_WP_EN)
> +               reg = ext_csd[EXT_CSD_BOOT_WP_STATUS];
> +               printf(" partition 0 ro lock status: ");
> +               if (reg & EXT_CSD_BOOT_WP_S_AREA_0_PERM)
> +                       printf("locked permanently\n");
> +               else if (reg & EXT_CSD_BOOT_WP_S_AREA_0_PWR)
>                         printf("locked until next power on\n");
> -               else if (reg & EXT_CSD_BOOT_WP_B_PERM_WP_EN)
> +               else
> +                       printf("not locked\n");
> +               printf(" partition 1 ro lock status: ");
> +               if (reg & EXT_CSD_BOOT_WP_S_AREA_1_PERM)
>                         printf("locked permanently\n");
> +               else if (reg & EXT_CSD_BOOT_WP_S_AREA_1_PWR)
> +                       printf("locked until next power on\n");
>                 else
>                         printf("not locked\n");
>         }
> @@ -260,13 +268,28 @@ int do_writeprotect_boot_set(int nargs, char **argv)
>         __u8 ext_csd[512], value;
>         int fd, ret;
>         char *device;
> +       char *end;
> +       int argi = 1;
> +       int permanent = 0;
> +       int partition = -1;
>
> -       if (nargs != 2) {
> -               fprintf(stderr, "Usage: mmc writeprotect boot set </path/to/mmcblkX>\n");
> +#ifdef DANGEROUS_COMMANDS_ENABLED
> +       if (!strcmp(argv[argi], "-p")){
> +               permanent = 1;
> +               argi++;
> +       }
> +#endif
> +
> +       if (nargs < 1 + argi ||  nargs > 2 + argi) {
> +               fprintf(stderr, "Usage: mmc writeprotect boot set "
> +#ifdef DANGEROUS_COMMANDS_ENABLED
> +                       "[-p] "
> +#endif
> +                       "</path/to/mmcblkX> [0|1]\n");
>                 exit(1);
>         }
>
> -       device = argv[1];
> +       device = argv[argi++];
>
>         fd = open(device, O_RDWR);
>         if (fd < 0) {
> @@ -274,14 +297,49 @@ int do_writeprotect_boot_set(int nargs, char **argv)
>                 exit(1);
>         }
>
> +       if (nargs == 1 + argi) {
> +               partition = strtoul(argv[argi], &end, 0);
> +               if (*end != '\0' || !(partition == 0 || partition == 1)) {
> +                       fprintf(stderr, "Invalid partition number (must be 0 or 1): %s\n",
> +                               argv[argi]);
> +                       exit(1);
> +               }
> +       }
> +
>         ret = read_extcsd(fd, ext_csd);
>         if (ret) {
>                 fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
>                 exit(1);
>         }
>
> -       value = ext_csd[EXT_CSD_BOOT_WP] |
> -               EXT_CSD_BOOT_WP_B_PWR_WP_EN;
> +       value = ext_csd[EXT_CSD_BOOT_WP];
> +       /*
> +        * If permanent protection is already on for one partition and we're
> +        * trying to enable power-reset protection for the other we need to make
> +        * sure the selection bit for permanent protection still points to the
> +        * former or we'll accidentally permanently protect the latter.
> +        */
> +       if ((value & EXT_CSD_BOOT_WP_B_PERM_WP_EN) && !permanent) {
> +               if (ext_csd[EXT_CSD_BOOT_WP_STATUS] &
> +                   EXT_CSD_BOOT_WP_S_AREA_1_PERM) {
> +                       value |= EXT_CSD_BOOT_WP_B_PERM_WP_SEC_SEL;
> +                       if (partition != 1)
> +                               partition = 0;
> +               } else {
> +                       /* PERM_WP_SEC_SEL cleared -> pointing to partition 0 */
> +                       if (partition != 0)
> +                               partition = 1;
> +               }
> +       }
> +       if (partition != -1) {
> +               value |= EXT_CSD_BOOT_WP_B_SEC_WP_SEL;
> +               if (partition == 1)
> +                       value |= permanent ? EXT_CSD_BOOT_WP_B_PERM_WP_SEC_SEL
> +                                          : EXT_CSD_BOOT_WP_B_PWR_WP_SEC_SEL;
> +       }
> +       value |= permanent ? EXT_CSD_BOOT_WP_B_PERM_WP_EN
> +                          : EXT_CSD_BOOT_WP_B_PWR_WP_EN;
> +
>         ret = write_extcsd_value(fd, EXT_CSD_BOOT_WP, value);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to "
> --
> 2.24.1
>

Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35699C433E1
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 09:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E116C619DB
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 09:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhCaJmh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 Mar 2021 05:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbhCaJmB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Mar 2021 05:42:01 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44B1C061764
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 02:41:59 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id a15so9587715vsi.0
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 02:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oWr5keBSXu/VzYXmMtBfBQP4nVSTH/rgALoTKEo/Blc=;
        b=cA767fX0JLG92+QApP0cyJuUiwXYFbAS5R8fCe5rCTIu6gW1T7hGgT1oczUvrTpLHK
         HkJRlmGadVug6dFyNMsDoU54gNlfWFGJCrEtSiLrVNq695do9GJLZe0Nlttm2n7FzAWa
         3+PXMtUQenYd6HAK7IXHvVuN0sAm9+VYcpdVthcgE5ZV3AmEnfDpjFi5IimnK3NRdAxN
         EXemw8yp/OvT/L/DdKO2/bOVg6JLHiGAkN6bBnT+I2vOsHRO6qHMDEdHLx5cKL0SDp3e
         I6GWxvLce7iza9zmVFtZNm/ipVOnBl+r+uG2noUnNeWmSqmDdSyBiU485mVmrbXXh2Nn
         tGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oWr5keBSXu/VzYXmMtBfBQP4nVSTH/rgALoTKEo/Blc=;
        b=XHGBZw+pwGCHrF+EhajPmZilTRkXq2w9sUCbZTdalKCM4VwLoYbGLf8qyWKZIGeceJ
         +x0M2jsaqk7AAyEjChSvBDQ/NYDKYRGozwGYWEaCZ0hAQiJf4CHi5K7Aag+oE3UIIOF7
         gXxnZe7uUWoO2QZTORYD0CTVCvruJnQo+ljigvbHmWYXRnHoHixjA7CsFMdMVxWRPPzq
         mzse/CgWs7XZlKDw4KUnPcb8gRsm/cHS79mQXrGAt1U+sEiUp38X21kpQr5uF/y5sQ6p
         TgdFxauZGqCqOmRISl+2PegIQc8wvkTfTx3y5uxMDN4Zdkbu5z8NOYkM61fUmLt1tcHo
         M5JA==
X-Gm-Message-State: AOAM531AZ5KOlQITVKTvQiLScRtZgwoiyU3BUc0RQfnnJvKE6snSnxv4
        0D8D6QZUTCprmmhbg/ibVPo89GOEGhk0jfPmS4ZOaa3Nh7GJsg==
X-Google-Smtp-Source: ABdhPJy8x+Glehd2QnB07nFGhjXFnzBfUbKvG88KkEH2o+9B4ufCt+F6kYHiJbmizYGZhFuNUWfvyYmr5m2LIXvC4nI=
X-Received: by 2002:a67:6942:: with SMTP id e63mr916089vsc.48.1617183718794;
 Wed, 31 Mar 2021 02:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <136642161.16716225.1547560620820.JavaMail.root@zimbra64-e11.priv.proxad.net>
 <1254580747.16828401.1547561163645.JavaMail.root@zimbra64-e11.priv.proxad.net>
In-Reply-To: <1254580747.16828401.1547561163645.JavaMail.root@zimbra64-e11.priv.proxad.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 31 Mar 2021 11:41:22 +0200
Message-ID: <CAPDyKFqfkAbYNdhqYm2AwqaUyoqAFhWgYGuDPahFiJo-7HEBuw@mail.gmail.com>
Subject: Re: [PATCH mmc-utils] Various fixes
To:     Stephane Fillod <f8cfe@free.fr>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Avri

On Tue, 15 Jan 2019 at 15:06, Stephane Fillod <f8cfe@free.fr> wrote:
>
> These warnings were mainly found using cppcheck.
>
> Signed-off-by: Stephane Fillod <f8cfe@free.fr>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
>
> Basically, these are signdness warnings about printf format
> (mainly on 32 bits arch), a few fd leaks (harmless if the programs
> ends afterwards) and 2 typos.
>
>   cppcheck -q $(CPPFLAGS) $(AM_CFLAGS) --enable=warning,style,performance,portability,information --suppress=variableScope: .
>
> diff --git a/lsmmc.c b/lsmmc.c
> index 9737b37..98c0c4d 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -512,9 +544,9 @@ void print_sd_cid(struct config *config, char *cid)
>                 printf("\tOID: %s\n", oid);
>                 printf("\tPNM: %s\n", pnm);
>                 printf("\tPRV: 0x%01x%01x ", prv_major, prv_minor);
> -               printf("(%d.%d)\n", prv_major, prv_minor);
> +               printf("(%u.%u)\n", prv_major, prv_minor);
>                 printf("\tPSN: 0x%08x\n", psn);
> -               printf("\tMDT: 0x%02x%01x %d %s\n", mdt_year, mdt_month,
> +               printf("\tMDT: 0x%02x%01x %u %s\n", mdt_year, mdt_month,
>                        2000 + mdt_year, months[mdt_month]);
>                 printf("\tCRC: 0x%02x\n", crc);
>         } else {
> @@ -524,9 +556,9 @@ void print_sd_cid(struct config *config, char *cid)
>                 else
>                         printf("manufacturer: 'Unlisted' '%s'\n", oid);
>
> -               printf("product: '%s' %d.%d\n", pnm, prv_major, prv_minor);
> +               printf("product: '%s' %u.%u\n", pnm, prv_major, prv_minor);
>                 printf("serial: 0x%08x\n", psn);
> -               printf("manfacturing date: %d %s\n", 2000 + mdt_year,
> +               printf("manufacturing date: %u %s\n", 2000 + mdt_year,
>                        months[mdt_month]);
>         }
>  }
> @@ -583,9 +615,9 @@ void print_mmc_cid(struct config *config, char *cid)
>                 printf("\tOID: 0x%01x\n", oid);
>                 printf("\tPNM: %s\n", pnm);
>                 printf("\tPRV: 0x%01x%01x ", prv_major, prv_minor);
> -               printf("(%d.%d)\n", prv_major, prv_minor);
> +               printf("(%u.%u)\n", prv_major, prv_minor);
>                 printf("\tPSN: 0x%08x\n", psn);
> -               printf("\tMDT: 0x%01x%01x %d %s\n", mdt_month, mdt_year,
> +               printf("\tMDT: 0x%01x%01x %u %s\n", mdt_month, mdt_year,
>                        1997 + mdt_year, months[mdt_month]);
>                 printf("\tCRC: 0x%02x\n", crc);
>         } else {
> @@ -595,9 +627,9 @@ void print_mmc_cid(struct config *config, char *cid)
>                 else
>                         printf("manufacturer: 'Unlisted' '%c'\n", oid);
>
> -               printf("product: '%s' %d.%d\n", pnm, prv_major, prv_minor);
> +               printf("product: '%s' %u.%u\n", pnm, prv_major, prv_minor);
>                 printf("serial: 0x%08x\n", psn);
> -               printf("manfacturing date: %d %s\n", 1997 + mdt_year,
> +               printf("manufacturing date: %u %s\n", 1997 + mdt_year,
>                        months[mdt_month]);
>         }
>  }
> @@ -687,7 +719,7 @@ void print_sd_csd(struct config *config, char *csd)
>
>                 printf("======SD/CSD======\n");
>
> -               printf("\tCSD_STRUCTURE: %d\n", csd_structure);
> +               printf("\tCSD_STRUCTURE: %u\n", csd_structure);
>                 printf("\tTAAC: 0x%02x (", taac);
>
>                 switch (taac_timevalue) {
> @@ -774,7 +806,7 @@ void print_sd_csd(struct config *config, char *csd)
>                 if (csd_structure == 1 && taac != 0x0e)
>                         printf("Warn: Invalid TAAC (should be 0x0e)\n");
>
> -               printf("\tNSAC: %d clocks\n", nsac);
> +               printf("\tNSAC: %u clocks\n", nsac);
>                 if (csd_structure == 1 && nsac != 0x00)
>                         printf("Warn: Invalid NSAC (should be 0x00)\n");
>
> @@ -1061,12 +1093,12 @@ void print_sd_csd(struct config *config, char *csd)
>                         if (erase_blk_en != 0x01)
>                                 printf("Warn: Invalid ERASE_BLK_EN (should be 0x01)\n");
>
> -                       printf("\tSECTOR_SIZE: 0x%02x (Erasable sector: %d blocks)\n",
> +                       printf("\tSECTOR_SIZE: 0x%02x (Erasable sector: %u blocks)\n",
>                                sector_size, sector_size + 1);
>                         if (sector_size != 0x7f)
>                                 printf("Warn: Invalid SECTOR_SIZE (should be 0x7f)\n");
>
> -                       printf("\tWP_GRP_SIZE: 0x%02x (Write protect group: %d blocks)\n",
> +                       printf("\tWP_GRP_SIZE: 0x%02x (Write protect group: %u blocks)\n",
>                                wp_grp_size, wp_grp_size + 1);
>                         if (wp_grp_size != 0x00)
>                                 printf("Warn: Invalid WP_GRP_SIZE (should be 0x00)\n");
> @@ -1075,7 +1107,7 @@ void print_sd_csd(struct config *config, char *csd)
>                         if (wp_grp_enable != 0x00)
>                                 printf("Warn: Invalid WP_GRP_ENABLE (should be 0x00)\n");
>
> -                       printf("\tR2W_FACTOR: 0x%01x (Write %d times read)\n",
> +                       printf("\tR2W_FACTOR: 0x%01x (Write %u times read)\n",
>                                r2w_factor, r2w_factor);
>                         if (r2w_factor != 0x02)
>                                 printf("Warn: Invalid R2W_FACTOR (should be 0x02)\n");
> @@ -1157,7 +1189,7 @@ void print_sd_csd(struct config *config, char *csd)
>                 else
>                         printf("%.2fbyte", memory_capacity * 1.0);
>
> -               printf(" (%lld bytes, %lld sectors, %d bytes each)\n",
> +               printf(" (%llu bytes, %llu sectors, %d bytes each)\n",
>                        memory_capacity, blocks, block_size);
>         } else {
>                 unsigned long long blocks = 0;
> @@ -1220,7 +1252,7 @@ void print_sd_csd(struct config *config, char *csd)
>                 else
>                         printf("%.2fbyte", memory_capacity * 1.0);
>
> -               printf(" (%lld bytes, %lld sectors, %d bytes each)\n",
> +               printf(" (%llu bytes, %llu sectors, %d bytes each)\n",
>                        memory_capacity, blocks, block_size);
>         }
>  }
> @@ -1414,7 +1446,7 @@ void print_mmc_csd(struct config *config, char *csd)
>                         break;
>                 }
>
> -               printf("\tNSAC: %d clocks\n", nsac);
> +               printf("\tNSAC: %u clocks\n", nsac);
>                 printf("\tTRAN_SPEED: 0x%02x (", tran_speed);
>                 switch (tran_speed_timevalue) {
>                 case 0x0:
> @@ -1722,10 +1754,10 @@ void print_mmc_csd(struct config *config, char *csd)
>
>                 printf("\tC_SIZE_MULT: 0x%01x\n", c_size_mult);
>                 printf("\tERASE_GRP_SIZE: 0x%02x\n", erase_grp_size);
> -               printf("\tERASE_GRP_MULT: 0x%02x (%d write blocks/erase group)\n",
> +               printf("\tERASE_GRP_MULT: 0x%02x (%u write blocks/erase group)\n",
>                        erase_grp_mult, (erase_grp_size + 1) *
>                        (erase_grp_mult + 1));
> -               printf("\tWP_GRP_SIZE: 0x%02x (%d blocks/write protect group)\n",
> +               printf("\tWP_GRP_SIZE: 0x%02x (%u blocks/write protect group)\n",
>                        wp_grp_size, wp_grp_size + 1);
>                 printf("\tWP_GRP_ENABLE: 0x%01x\n", wp_grp_enable);
>
> @@ -1742,7 +1774,7 @@ void print_mmc_csd(struct config *config, char *csd)
>                         break;
>                 }
>
> -               printf("\tR2W_FACTOR: 0x%01x (Write %d times read)\n",
> +               printf("\tR2W_FACTOR: 0x%01x (Write %u times read)\n",
>                        r2w_factor, r2w_factor);
>
>                 printf("\tWRITE_BL_LEN: 0x%01x (", write_bl_len);
> @@ -1872,7 +1904,7 @@ void print_mmc_csd(struct config *config, char *csd)
>                 else
>                         printf("%.2fbyte", memory_capacity * 1.0);
>
> -               printf(" (%lld bytes, %lld sectors, %d bytes each)\n",
> +               printf(" (%llu bytes, %llu sectors, %d bytes each)\n",
>                        memory_capacity, blocks, block_size);
>         } else {
>                 int mult;
> @@ -1949,7 +1981,7 @@ void print_mmc_csd(struct config *config, char *csd)
>                         printf("%.2fKbyte", memory_capacity / (1024.0));
>                 else
>                         printf("%.2fbyte", memory_capacity * 1.0);
> -               printf(" (%lld bytes, %lld sectors, %d bytes each)\n",
> +               printf(" (%llu bytes, %llu sectors, %d bytes each)\n",
>                        memory_capacity, blocks, block_size);
>         }
>  }
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 19a9da1..9402112 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -252,6 +252,7 @@ int do_writeprotect_boot_get(int nargs, char **argv)
>
>         print_writeprotect_boot_status(ext_csd);
>
> +       close(fd);
>         return ret;
>  }
>
> @@ -290,6 +291,7 @@ int do_writeprotect_boot_set(int nargs, char **argv)
>                 exit(1);
>         }
>
> +       close(fd);
>         return ret;
>  }
>
> @@ -378,6 +380,7 @@ int do_writeprotect_user_get(int nargs, char **argv)
>         if (last_wpblk != (x + y - 1))
>                 print_wp_status(wp_sizeblks, last_wpblk, cnt - 1, last_prot);
>
> +       close(fd);
>         return ret;
>  }
>
> @@ -524,6 +527,7 @@ int do_disable_512B_emulation(int nargs, char **argv)
>                 printf("MMC does not support disabling 512B emulation mode.\n");
>         }
>
> +       close(fd);
>         return ret;
>  }
>
> @@ -595,6 +599,7 @@ int do_write_boot_en(int nargs, char **argv)
>                         value, EXT_CSD_PART_CONFIG, device);
>                 exit(1);
>         }
> +       close(fd);
>         return ret;
>  }
>
> @@ -716,6 +721,7 @@ int do_hwreset(int value, int nargs, char **argv)
>                 exit(1);
>         }
>
> +       close(fd);
>         return ret;
>  }
>
> @@ -766,6 +772,7 @@ int do_write_bkops_en(int nargs, char **argv)
>                 exit(1);
>         }
>
> +       close(fd);
>         return ret;
>  }
>
> @@ -796,6 +803,7 @@ int do_status_get(int nargs, char **argv)
>
>         printf("SEND_STATUS response: 0x%08x\n", response);
>
> +       close(fd);
>         return ret;
>  }
>
> @@ -1615,11 +1623,11 @@ int do_read_extcsd(int nargs, char **argv)
>                 printf("Write reliability setting register"
>                         " [WR_REL_SET]: 0x%02x\n", reg);
>
> -               printf(" user area: %s\n", reg & (1<<0) ? reliable : fast);
> +               printf(" user area: %s\n", (reg & (1<<0)) ? reliable : fast);
>                 int i;
>                 for (i = 1; i <= 4; i++) {
>                         printf(" partition %d: %s\n", i,
> -                               reg & (1<<i) ? reliable : fast);
> +                               (reg & (1<<i)) ? reliable : fast);
>                 }
>
>                 reg = ext_csd[EXT_CSD_WR_REL_PARAM];
> @@ -1805,6 +1813,7 @@ int do_sanitize(int nargs, char **argv)
>                 exit(1);
>         }
>
> +       close(fd);
>         return ret;
>
>  }
> @@ -2390,6 +2399,7 @@ int do_cache_ctrl(int value, int nargs, char **argv)
>                 exit(1);
>         }
>
> +       close(fd);
>         return ret;
>  }
>

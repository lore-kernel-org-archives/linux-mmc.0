Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4C02417F8
	for <linux-mmc@vger.kernel.org>; Tue, 15 Jul 2025 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589646; cv=none; b=TLfhWRbxFDYXXAchwqiqtoG9RVTy9B9cKuk3NiXsrd4P25wmbq1v5lvDUyUdXVtlzBEsaVfheLxo1YP22goZMf3yssptmxD+jB5Pn0ILYFQZNZexvvMSzTE8OdgdrjyOq9Oztn2kX7NrHqpoZz3keIBam1B+s+jDQIIf7qxBoB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589646; c=relaxed/simple;
	bh=X3PID5gdgQXuLRjqjI300nAbUeoZcEeofNOu4qAX7dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6sxGkpj2ZGoe1yMzWjUKYlS3yQ9zS+/Xint9iJ1CiHw/l78U+26s75MwQu7wswH9PM+ahHTODaKE0syY0JWrDLXes2a5RzyyX0kmDNKTu/Tg6xWs+H2lIqb5pAj0XpzNa59v58kmG3lhisoqjTZPfFer5s8MHTKoTWE0OKUm0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=we3HVErg; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="we3HVErg"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-710e344bbf9so54147297b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 15 Jul 2025 07:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752589643; x=1753194443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eWLAb289PJExktvuJr/kZYZdElgeoxv1Etz0uQ+Kxiw=;
        b=we3HVErgzX+Gd0tPlob7+0N+z+IrBYztYHAcenbMtQxNiZ/cGmLe78Oi6HL3YdekfT
         be/uueAmMMZ75GD3tZdAAjrg2POEQf061ihi3rHmhLMBdfP6ZXiPOq+cw2iIYmdaG4bz
         337dCoat29fCj2gKQXVBSn8/tjsMetf8zOy0Edlepso2xxrX6b3Pn/ZNHogcKYZVGwpD
         u3rZ16/+usG/k1LoGosOqUtRcuo8mZECDncK/RR5aNKjddT65UDlDnf4Vqrza0rL327L
         oss3NkSnavRutwP0gi8CwpoxLDAnY9gu71Y3of5MYKdwGhBd2ZTu/dZm0SAwSOZuxEar
         SoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752589643; x=1753194443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWLAb289PJExktvuJr/kZYZdElgeoxv1Etz0uQ+Kxiw=;
        b=C/bBmN5szgRP9vZlzMKzPDmdHxz3J7x05txDhNY4u/N7fp8lBCr7g5YeQ5bwPB4Xeb
         tQELg5oSEFSOuTkDaExvNCOVfxoZArxv6SuUpaNLdBrKljFxLqcqUv6r40hvE6FULZXS
         jgn98wpIXt5EpJa5bOTKBSrzFGZdTSzhfs1S7jiNC/5ZwyhSxgyZllvZFIi4sc+s+BV+
         IK3WQ0aPa1QibnW6N7o8q4TIj2XGSNzj11OErjxy2w6ucYAOj0IoCGJluH0Onbloo9HF
         zgvBYySBWZLVAh3fe1wlCinnJAvxWiTB5zBTYUkZq6RzgtHdXElV4faP2Se6CN0mMsSC
         LRMA==
X-Gm-Message-State: AOJu0Yxuknr3tfrirK5U4si2AuwBIwNiTHhf6sKmDIHHjBYL2w4WpcTv
	HcJgCaPmWXzk2p8rCQNiby4P4vEUkNEX2Y9UfL+RTpv+Jvrz6H01wpU5vB4+eqhhy2GUs/UTJEO
	OLNqmE7HPHyuEwx67gE9AjPfgcC03+oRmZr0c94oLWH/AsmOcZijWep0=
X-Gm-Gg: ASbGncsjFkFjUnfh4lbnCTLF/ddtFXOC7s2WzrwdzgEIzpS+XwU8dAtSrfPwX58VoQd
	ZBg5U2nirxl0wIDqKOnrGgp/cY6rg//DcvP6Zz9u4GxuTkb5xTpBVG5ap0G74LjorOfANq8pnV3
	0oNrctstNxmrY+qsCPOQm/0lslRDWoVTf7BEyNVyxuDPXzhJvE85a9vx1wHDoAtUovK+52N1kT1
	K8HuIwT
X-Google-Smtp-Source: AGHT+IEvUGk+oixDM63jLeqXSLbGrnSvmVTEMGW3pDl0s3hGBi4McPikLd58PoSBjabZYqSzsTkxbHAB1gqBNWc96Cw=
X-Received: by 2002:a05:690c:4c0e:b0:709:1529:c24f with SMTP id
 00721157ae682-717d78afca1mr245307027b3.4.1752589642586; Tue, 15 Jul 2025
 07:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714064807.1915470-1-michele.dionisio@gmail.com>
In-Reply-To: <20250714064807.1915470-1-michele.dionisio@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 15 Jul 2025 16:26:46 +0200
X-Gm-Features: Ac12FXxgRbMXV6665tmAYdLt473_mkABsgOD98Zf44Hqnu_-8p4k6AN58NGVKzs
Message-ID: <CAPDyKFr_X3mNC1=KdVT08N+enbeg5hi0YA04KMtSATLiyswVAw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc-utils: add ability to flush optional eMMC cache
To: Michele Dionisio <michele.dionisio@gmail.com>
Cc: linux-mmc@vger.kernel.org, Avri Altman <Avri.Altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Jul 2025 at 08:48, Michele Dionisio
<michele.dionisio@gmail.com> wrote:
>
> The MMC 5.0 instroduce command to flush cache. This feature can be use on
> embedded device there power is not stable.
>
>
> Signed-off-by: Michele Dionisio <michele.dionisio@gmail.com>

Applied for mmc-utils master, thanks!

Kind regards
Uffe

> ---
> Changes since v1:
>  - Remove redundant cover letter
>  - Add docs/HOWTO.rst
>  - add check to not flush if cache is disabled
>
>  docs/HOWTO.rst |  5 +++++
>  man/mmc.1      |  4 ++++
>  mmc.c          |  5 +++++
>  mmc.h          |  1 +
>  mmc_cmds.c     | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h     |  1 +
>  6 files changed, 68 insertions(+)
>
> diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
> index f2f2f35..d454d8c 100644
> --- a/docs/HOWTO.rst
> +++ b/docs/HOWTO.rst
> @@ -107,3 +107,8 @@ Running mmc-utils
>      ``mmc rpmb secure-wp-enable <rpmb device> <key file>``
>          Disable updating WP related EXT_CSD and CSD fields.
>          Applicable only if secure write protect mode is enabled.
> +
> +
> +    ``mmc cache flush <device>``
> +        Flush the eMMC cache for <device>.
> +        Applicable only if device version >= eMMC5.0.
> diff --git a/man/mmc.1 b/man/mmc.1
> index bccabf3..665fe6d 100644
> --- a/man/mmc.1
> +++ b/man/mmc.1
> @@ -109,6 +109,10 @@ NOTE! The cache is an optional feature on devices >= eMMC4.5.
>  Disable the eMMC cache feature on <device>.
>  NOTE! The cache is an optional feature on devices >= eMMC4.5.
>  .TP
> +.BR "cache flush <device>"
> +Flush the eMMC cache on <device>.
> +NOTE! The cache is an optional feature on devices >= eMMC5.0.
> +.TP
>  .BR "<cmd> --help"
>  Show detailed help for a command or subset of commands.
>
> diff --git a/mmc.c b/mmc.c
> index 6770a45..fce7eef 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -231,6 +231,11 @@ static struct Command commands[] = {
>                 "Disable the eMMC cache feature on <device>.\n"
>                 "NOTE! The cache is an optional feature on devices >= eMMC4.5.",
>         },
> +       { do_cache_flush, 1,
> +         "cache flush", "<device>\n"
> +               "flush the eMMC cache <device>.\n"
> +               "NOTE! The cache is an optional feature on devices >= eMMC5.0.",
> +       },
>         { do_read_csd, -1,
>           "csd read", "<device path>\n"
>                   "Print CSD data from <device path>.\n"
> diff --git a/mmc.h b/mmc.h
> index 9fc22ec..2bb346b 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -152,6 +152,7 @@
>  #define EXT_CSD_DATA_SECTOR_SIZE       61 /* R */
>  #define EXT_CSD_EXT_PARTITIONS_ATTRIBUTE_1     53
>  #define EXT_CSD_EXT_PARTITIONS_ATTRIBUTE_0     52
> +#define EXT_CSD_FLUSH_CACHE     32
>  #define EXT_CSD_CACHE_CTRL             33
>  #define EXT_CSD_MODE_CONFIG            30
>  #define EXT_CSD_MODE_OPERATION_CODES   29      /* W */
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index d56a3ed..16c6b2e 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2865,6 +2865,58 @@ int do_cache_dis(int nargs, char **argv)
>         return do_cache_ctrl(0, nargs, argv);
>  }
>
> +int do_cache_flush(int nargs, char **argv)
> +{
> +       __u8 ext_csd[512];
> +       int fd, ret;
> +       char *device;
> +
> +       device = argv[1];
> +
> +       fd = open(device, O_RDWR);
> +       if (fd < 0) {
> +               perror("open");
> +               exit(1);
> +       }
> +
> +       ret = read_extcsd(fd, ext_csd);
> +       if (ret) {
> +               fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
> +               exit(1);
> +       }
> +
> +       if (ext_csd[EXT_CSD_REV] < EXT_CSD_REV_V5_0) {
> +               fprintf(stderr,
> +                       "The CACHE FLUSH option is only availabe on devices >= "
> +                       "MMC 5.0 %s\n", device);
> +               exit(1);
> +       }
> +
> +       /* If the cache size is zero, this device does not have a cache */
> +       if (!(ext_csd[EXT_CSD_CACHE_SIZE_3] ||
> +                       ext_csd[EXT_CSD_CACHE_SIZE_2] ||
> +                       ext_csd[EXT_CSD_CACHE_SIZE_1] ||
> +                       ext_csd[EXT_CSD_CACHE_SIZE_0])) {
> +               fprintf(stderr,
> +                       "The CACHE option is not available on %s\n",
> +                       device);
> +               exit(1);
> +       }
> +
> +       if (ext_csd[EXT_CSD_CACHE_CTRL]) {
> +               ret = write_extcsd_value(fd, EXT_CSD_FLUSH_CACHE, 1, 0);
> +               if (ret) {
> +                       fprintf(stderr,
> +                               "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
> +                               EXT_CSD_FLUSH_CACHE, EXT_CSD_FLUSH_CACHE, device);
> +                       exit(1);
> +               }
> +       }
> +
> +       close(fd);
> +       return 0;
> +}
> +
>  static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
>  {
>         int ret = 0;
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index ce35d3e..f767deb 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -50,6 +50,7 @@ int do_rpmb_sec_wp_mode_clear(int nargs, char **argv);
>  int do_rpmb_sec_wp_en_read(int nargs, char **argv);
>  int do_cache_en(int nargs, char **argv);
>  int do_cache_dis(int nargs, char **argv);
> +int do_cache_flush(int nargs, char **argv);
>  int do_ffu(int nargs, char **argv);
>  int do_opt_ffu1(int nargs, char **argv);
>  int do_opt_ffu2(int nargs, char **argv);
> --
> 2.43.0
>

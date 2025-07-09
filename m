Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1B82E762C
	for <linux-mmc@vger.kernel.org>; Wed,  9 Jul 2025 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069787; cv=none; b=akbWOuSuQx9e1PA2gXCT0tVEf4RQJZJuS8kSMdYDZX5WzUoTH9GiPACrQK3QWfWp7N8d5a8W0EQDZyYcutyMGQcdeK2HbQ/teskuzmpUzB2gtJj230paoELCwVzHSwGfSmNCF98LpX2pm84ZmeNFVyj07MR09X8ZW1HLpEehAw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069787; c=relaxed/simple;
	bh=aYNwcmp6UdDJPSMPvE55wuPKGskPiCCegGcpt6nD608=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amHekBq1rHFloiCT0XWXkpsOl/qbh/P7Im3g0/i8yvGHxCmCWyT83xZKdPnWFM0DjqV4D14biS8qRQM6Lw3bor09poJ2x6vULWj+gzObUCZvU2BUA9AiQnBcF1zAyfieLuldlcMneADlBNaB2f89yjUKNPKxTxdlKoLXLRgCQVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AWjcroKE; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AWjcroKE"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-711a3dda147so53730727b3.2
        for <linux-mmc@vger.kernel.org>; Wed, 09 Jul 2025 07:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752069785; x=1752674585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AQn80SrSvvDHnr/WZFGFVQFYZom8pEAvBXgScEVS7/A=;
        b=AWjcroKETIWPJVBsuYD1ldI27mdO2/zo902dPWA8hvmmiDfxV084AsgUvvTwGI+PV2
         GE+Hluzk2Oz/VT95FNKmNq1KqqK+tKxHzhnW4jyrZnPgKpzO9hFxYfZP/l5bEidFm89n
         1ktMZCzV1rn2b2pmYcJqXO+knGKHsRbvedG6HkKca1aUg6T7i5xB3WxkY3K0uDWzUcdF
         eFmi/Evbu4IgYmShknR7gOVX5z1fvHAxgK1MfEuHoROjoX6r3vGw7N8vwLLE46KpBeMx
         hOSfgOCZHjLgswGBDLXO3QYEpG7XwKFUoaToN7xqmANDSFfumjiM0CD5Qcan+mGIr+z/
         9x7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752069785; x=1752674585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQn80SrSvvDHnr/WZFGFVQFYZom8pEAvBXgScEVS7/A=;
        b=IBXODiZ95qoZTPDZNCP1Kp/jeqM2rAWg1mf3RkU1eITP2aFdA0qZXPJDLBLXLGo1Rr
         3hP2fwtFfvGvXRr2+mE4vL88XgdgXTkrLWeEFAWTbns7rooulFTUL3VYpyLW/quf0LRw
         x7rul+FDZCbAKB9uQx/+T0EhT++5+nLbmztoD/dO7wKUDybDeTHWd91Av0WK7BVOm/RP
         uUyiO+d2+vGRLpduTnqJhV3RRtvAvNRqPoDyKwOq4ymvLQ6MJYXn8ke8dGRKqb9XNsUq
         krv6E2Bsxrx4PIj5IZhh7zvc7F09PSpLl+m+w5qbOl2kswWc5W5ztL/VxWrH0DMyogu1
         4SSw==
X-Gm-Message-State: AOJu0Yy20vfW91L7GFYDZX28eQp1W839zh+xBoq3AV+m9QIcrlKPU0Wv
	QE6KovGy0k43/MKrrNv2eSri216U+hWx4KJIhXlZnJA+4E93sleVu2X8Yo7tC/Cc/NrKeiJ+jnM
	n97RF4qfyAywJM8vqjRJp8UkDtLq5qyZBt8Nq0INPiCqUIHnhb2nN
X-Gm-Gg: ASbGncvS9PoJzBmDZa78iGUCtOELCWNyrBN0HbsS96ZNXTnpW9uD60NprI49HRM8jR9
	i89s6XqDk6RgbhC99h53NO8bvLVsHxFob+lAaNpL+QYtKQH9xu1I8t1jdD4L9ygc4ThDWVAFybi
	IbjqRJXEZ2WVAz6lmPI6PDncN0MPiI8OEaeczMkCWk1+c/
X-Google-Smtp-Source: AGHT+IHXWYJJVKBEPY0bcgI+c6VmXqIiCfvYGgV+ZqHnvXIjsaltAEOkVn5TptO68YaAx8K37otoU4BHLzcOge1g5w4=
X-Received: by 2002:a05:690c:4493:b0:70e:7ff6:9ff3 with SMTP id
 00721157ae682-717b1a17560mr40318167b3.35.1752069784459; Wed, 09 Jul 2025
 07:03:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250706120637.59267-1-avri.altman@sandisk.com>
In-Reply-To: <20250706120637.59267-1-avri.altman@sandisk.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Jul 2025 16:02:28 +0200
X-Gm-Features: Ac12FXxGBxv7CPI5t2qihSRt2HB8em8kGxxbcDkQ84_62zTQUw6sJAZmwSNXgoI
Message-ID: <CAPDyKFpD9NH_UawekwJ+f3buetNQbRO19YGoF8VJ_KnFtdmGGg@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: Use designated initializers for struct zeroing
To: Avri Altman <avri.altman@sandisk.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 6 Jul 2025 at 14:06, Avri Altman <avri.altman@sandisk.com> wrote:
>
> Replace memset-based struct zero-initialization with C99 designated
> initializers for improved clarity and safety.
>
> Signed-off-by: Avri Altman <avri.altman@sandisk.com>

Applied for mmc-utils, thanks!

Kind regards
Uffe


> ---
>  mmc_cmds.c | 50 ++++++++++++++++++++------------------------------
>  1 file changed, 20 insertions(+), 30 deletions(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 7994223..c781aba 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -77,8 +77,8 @@ static inline __u32 per_byte_htole32(__u8 *arr)
>  static int read_extcsd(int fd, __u8 *ext_csd)
>  {
>         int ret = 0;
> -       struct mmc_ioc_cmd idata;
> -       memset(&idata, 0, sizeof(idata));
> +       struct mmc_ioc_cmd idata = {};
> +
>         memset(ext_csd, 0, sizeof(__u8) * 512);
>         idata.write_flag = 0;
>         idata.opcode = MMC_SEND_EXT_CSD;
> @@ -125,9 +125,8 @@ write_extcsd_value(int fd, __u8 index, __u8 value, unsigned int timeout_ms)
>  static int send_status(int fd, __u32 *response)
>  {
>         int ret = 0;
> -       struct mmc_ioc_cmd idata;
> +       struct mmc_ioc_cmd idata = {};
>
> -       memset(&idata, 0, sizeof(idata));
>         idata.opcode = MMC_SEND_STATUS;
>         idata.arg = (1 << 16);
>         idata.flags = MMC_RSP_R1 | MMC_CMD_AC;
> @@ -159,9 +158,8 @@ static __u32 get_size_in_blks(int fd)
>  static int set_write_protect(int fd, __u32 blk_addr, int on_off)
>  {
>         int ret = 0;
> -       struct mmc_ioc_cmd idata;
> +       struct mmc_ioc_cmd idata = {};
>
> -       memset(&idata, 0, sizeof(idata));
>         idata.write_flag = 1;
>         if (on_off)
>                 idata.opcode = MMC_SET_WRITE_PROT;
> @@ -180,12 +178,11 @@ static int set_write_protect(int fd, __u32 blk_addr, int on_off)
>  static int send_write_protect_type(int fd, __u32 blk_addr, __u64 *group_bits)
>  {
>         int ret = 0;
> -       struct mmc_ioc_cmd idata;
> +       struct mmc_ioc_cmd idata = {};
>         __u8 buf[8];
>         __u64 bits = 0;
>         int x;
>
> -       memset(&idata, 0, sizeof(idata));
>         idata.write_flag = 0;
>         idata.opcode = MMC_SEND_WRITE_PROT_TYPE;
>         idata.blksz      = 8,
> @@ -2192,9 +2189,7 @@ static int do_rpmb_op(int fd, const struct rpmb_frame *frame_in,
>         u_int16_t rpmb_type;
>         struct mmc_ioc_multi_cmd *mioc;
>         struct mmc_ioc_cmd *ioc;
> -       struct rpmb_frame frame_status;
> -
> -       memset(&frame_status, 0, sizeof(frame_status));
> +       struct rpmb_frame frame_status = {};
>
>         if (!frame_in || !frame_out || !out_cnt)
>                 return -EINVAL;
> @@ -3121,9 +3116,7 @@ static bool ffu_is_supported(__u8 *ext_csd, char *device)
>  static int enter_ffu_mode(int dev_fd)
>  {
>         int ret;
> -       struct mmc_ioc_cmd cmd;
> -
> -       memset(&cmd, 0, sizeof(cmd));
> +       struct mmc_ioc_cmd cmd = {};
>
>         fill_switch_cmd(&cmd, EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
>         ret = ioctl(dev_fd, MMC_IOC_CMD, &cmd);
> @@ -3136,9 +3129,7 @@ static int enter_ffu_mode(int dev_fd)
>  static int exit_ffu_mode(int dev_fd)
>  {
>         int ret;
> -       struct mmc_ioc_cmd cmd;
> -
> -       memset(&cmd, 0, sizeof(cmd));
> +       struct mmc_ioc_cmd cmd = {};
>
>         fill_switch_cmd(&cmd, EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
>         ret = ioctl(dev_fd, MMC_IOC_CMD, &cmd);
> @@ -3461,7 +3452,13 @@ int do_general_cmd_read(int nargs, char **argv)
>         __u8 buf[512];
>         __u32 arg = 0x01;
>         int ret = -EINVAL, i;
> -       struct mmc_ioc_cmd idata;
> +       struct mmc_ioc_cmd idata = {
> +               .write_flag = 0,
> +               .opcode = MMC_GEN_CMD,
> +               .flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC,
> +               .blksz = 512,
> +               .blocks = 1
> +       };
>
>         if (nargs != 2 && nargs != 3) {
>                 print_usage(do_general_cmd_read);
> @@ -3484,13 +3481,7 @@ int do_general_cmd_read(int nargs, char **argv)
>                 }
>         }
>
> -       memset(&idata, 0, sizeof(idata));
> -       idata.write_flag = 0;
> -       idata.opcode = MMC_GEN_CMD;
>         idata.arg = arg;
> -       idata.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> -       idata.blksz = 512;
> -       idata.blocks = 1;
>         mmc_ioc_cmd_set_data(idata, buf);
>
>         ret = ioctl(dev_fd, MMC_IOC_CMD, &idata);
> @@ -3512,7 +3503,11 @@ out:
>
>  static void issue_cmd0(char *device, __u32 arg)
>  {
> -       struct mmc_ioc_cmd idata;
> +       struct mmc_ioc_cmd idata = {
> +               .opcode = MMC_GO_IDLE_STATE,
> +               .flags = MMC_RSP_NONE | MMC_CMD_BC,
> +               .arg = arg,
> +       };
>         int fd;
>
>         fd = open(device, O_RDWR);
> @@ -3521,11 +3516,6 @@ static void issue_cmd0(char *device, __u32 arg)
>                 exit(1);
>         }
>
> -       memset(&idata, 0, sizeof(idata));
> -       idata.opcode = MMC_GO_IDLE_STATE;
> -       idata.arg = arg;
> -       idata.flags = MMC_RSP_NONE | MMC_CMD_BC;
> -
>         /* No need to check for error, it is expected */
>         ioctl(fd, MMC_IOC_CMD, &idata);
>         close(fd);
> --
> 2.34.1
>

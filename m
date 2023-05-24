Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B74BC77B7A
	for <linux-mmc@archiver.kernel.org>; Wed, 24 May 2023 13:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbjEXNL7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 May 2023 09:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjEXNLf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 May 2023 09:11:35 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB22C1
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2023 06:11:25 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-561da492bcbso13167687b3.3
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2023 06:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684933885; x=1687525885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8YMChv0Kbwi+1uRdxv5SOqopG6OU3NDn7YchG3hX0Iw=;
        b=FzhfdVCfaEF8SeFwWuGcxH53uaFvlyDENmSU3rCkUWDk0E0q3sFBoCrO7Tdr46T3r4
         Vyjr7hIn2/iQaJZ/65nivMCr8UpwPV/A1tBlrI4EGVPm3yni77wjoHJH9E4yfmoPgS4v
         gaOAUYjzUnzM2AQZrdtrHAatCfewAiN5c00Jru3Smpl4RIBRuwmT9CNa3wQA891lqDC1
         ZVAiD8hq/eV6blv1yT/lBY8oCwZ1g9me6RH8R3R5vgSgOLct8/rZq19C9GfHFJaqUNET
         Gr1jwoCG6svyPkrBYWFh5VJRypt3KC7ukY5ySxmBTcKNA1JYAERPQWVJi2G5q9bPujxb
         rfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684933885; x=1687525885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YMChv0Kbwi+1uRdxv5SOqopG6OU3NDn7YchG3hX0Iw=;
        b=b+ZYV47vSGQRJWfCjTPMA4E9oS1hTQ/t4KuGl4gJhmAIedbUFMWBuNtsAivXkcQ9S7
         oXGre46fhfS2/EqDOrTlh7gBNp6vNie3H8djNmdTmYKYhZWcXS2StyNaZfhu3QkLdpdJ
         TfgOFTxyOhuXe0F6gaskX/jiT7/osA5KBimfH40SRaMY9id0HS8kCV7TGhAPGqLRMqqF
         O+HjQQ4PH0A3LBqleysw4Sy3qg38ZHWKeFW4AU/5JXKSsJSl6gMVzcqPZuspw6uuPNDQ
         0MLvdelZs20JFucPyRQmqS/4VbFnuy8mnW4fb0H3r0UHjqNmbd0C4HSsXMTA1Uu14kdS
         vz+A==
X-Gm-Message-State: AC+VfDyNikN1mbcV1PQe4wV3ZcoqPPTDrrDbpHlYsX9V0R1+xBn+75MS
        gbGza7kXefgCXPkRhAHTrYfFvdhINr4xP8efIMfFMIZ1ECxTYk1+
X-Google-Smtp-Source: ACHHUZ5jC4QdtoAG2YFQReK8EIv0ceZyovFAuJzf8NehJc1JaI9nZSehPe/mk/8GQTmaDHWY9QXTNtT6G3XHe5ugM+I=
X-Received: by 2002:a81:71d7:0:b0:55d:a4fb:864a with SMTP id
 m206-20020a8171d7000000b0055da4fb864amr18918048ywc.14.1684933885028; Wed, 24
 May 2023 06:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <048cd6972c50c33c2e8f81d5228fed928519918b.1683987673.git.deren.wu@mediatek.com>
In-Reply-To: <048cd6972c50c33c2e8f81d5228fed928519918b.1683987673.git.deren.wu@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 May 2023 15:10:49 +0200
Message-ID: <CAPDyKFoTkEp53hxw3rC1H2n+Z6Jm9DkSND8=PSd-3oFehWEeOQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: vub300: fix invalid response handling
To:     Deren Wu <deren.wu@mediatek.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 13 May 2023 at 16:49, Deren Wu <deren.wu@mediatek.com> wrote:
>
> We may get an empty response with zero length at the beginning of
> the driver start and get following UBSAN error. Since there is no
> content(SDRT_NONE) for the response, just return and skip the response
> handling to avoid this problem.
>
> Test pass : SDIO wifi throughput test with this patch
>
> [  126.980684] UBSAN: array-index-out-of-bounds in drivers/mmc/host/vub300.c:1719:12
> [  126.980709] index -1 is out of range for type 'u32 [4]'
> [  126.980729] CPU: 4 PID: 9 Comm: kworker/u16:0 Tainted: G            E      6.3.0-rc4-mtk-local-202304272142 #1
> [  126.980754] Hardware name: Intel(R) Client Systems NUC8i7BEH/NUC8BEB, BIOS BECFL357.86A.0081.2020.0504.1834 05/04/2020
> [  126.980770] Workqueue: kvub300c vub300_cmndwork_thread [vub300]
> [  126.980833] Call Trace:
> [  126.980845]  <TASK>
> [  126.980860]  dump_stack_lvl+0x48/0x70
> [  126.980895]  dump_stack+0x10/0x20
> [  126.980916]  ubsan_epilogue+0x9/0x40
> [  126.980944]  __ubsan_handle_out_of_bounds+0x70/0x90
> [  126.980979]  vub300_cmndwork_thread+0x58e7/0x5e10 [vub300]
> [  126.981018]  ? _raw_spin_unlock+0x18/0x40
> [  126.981042]  ? finish_task_switch+0x175/0x6f0
> [  126.981070]  ? __switch_to+0x42e/0xda0
> [  126.981089]  ? __switch_to_asm+0x3a/0x80
> [  126.981129]  ? __pfx_vub300_cmndwork_thread+0x10/0x10 [vub300]
> [  126.981174]  ? __kasan_check_read+0x11/0x20
> [  126.981204]  process_one_work+0x7ee/0x13d0
> [  126.981246]  worker_thread+0x53c/0x1240
> [  126.981291]  kthread+0x2b8/0x370
> [  126.981312]  ? __pfx_worker_thread+0x10/0x10
> [  126.981336]  ? __pfx_kthread+0x10/0x10
> [  126.981359]  ret_from_fork+0x29/0x50
> [  126.981400]  </TASK>
>
> Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> v2: add Fixes tag
>     update commit description
> ---
>  drivers/mmc/host/vub300.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index e4c4bfac3763..9ec593d52f0f 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -1713,6 +1713,9 @@ static void construct_request_response(struct vub300_mmc_host *vub300,
>         int bytes = 3 & less_cmd;
>         int words = less_cmd >> 2;
>         u8 *r = vub300->resp.response.command_response;
> +
> +       if (!resp_len)
> +               return;
>         if (bytes == 3) {
>                 cmd->resp[words] = (r[1 + (words << 2)] << 24)
>                         | (r[2 + (words << 2)] << 16)
> --
> 2.18.0
>

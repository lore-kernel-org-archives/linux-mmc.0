Return-Path: <SRS0=Im6a=45=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098CCC10DCE
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 13:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D222B2067C
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 13:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nykjnDhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgCLNJG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:09:06 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37256 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgCLNJG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Mar 2020 09:09:06 -0400
Received: by mail-ua1-f66.google.com with SMTP id h32so2079948uah.4
        for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2020 06:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VvbUfBZDtdgI8tgmANPlv6VyPvPhc3hq5N3KkYFOltk=;
        b=nykjnDhEEOE8Wg0dj0Lyxd+ejz5A8qfP5kiHGvAU7qgEMZYItQXh0J64vUCINIhqWy
         5Pev9lKS9Y4pGJcupBdlKAnSztVqnNGOISTrDJpDXB59zoKInTwzPJ+ohLzpSSR4MTlP
         ZLh6kW862UnGxGXlK/kCxc/79KOvBaonzPMQNMRGUUdvbCKT+HfMrQIE7dOuqA2EAEpT
         v1TrSMeusguNz7cv4qrXEFcrQZ1M+t+SDcpERVfw048QoNgoKu8zu5FCAUTIpWJ/AuE1
         C/+sENzriiV8coDRIY4Hxl5NxgLW1u9t0xPlkKfxrsIzUfRy+h3+J66U+796dIGm5xB5
         fV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VvbUfBZDtdgI8tgmANPlv6VyPvPhc3hq5N3KkYFOltk=;
        b=BBW6fgvk+bE+GrHOEgxW+qyP2Hp7nyhwk6cF1Q2JvIGrHbTIOWJtQAUzym+N7/lShA
         dpPiGaOYjM7YA/qSYtIbhRZlHUl5VmogCL+0oy8IGIp4YFGkuOfbBFQI8n3TvdzXi3ZL
         YPV7m3+dptWcMfEJO7bYQ9738pjCJCQYWfWcgr/IH5GRaSYsRhuGsmLHzzNdQ8n/kQj4
         CaWMFGp2282wEVo7UMucsjjzX0R+rIOh/3Qd+BoLJn4Q7apDtjcVs2q+n8c4l5s7/V4j
         LCEbLz36LtXlTkB3KQ22gNVKiJ9j8JVLi6xOm4hbS1eKp81Kw+0Icw93MOHO6b/wDYW8
         R1uw==
X-Gm-Message-State: ANhLgQ0ulva4TMzxdPydOQdKMRgmgao6RS+Mb+rqPncv8qtqCt+S3dEm
        iCC+hd/U7UShdbMGtzpM54L+KYNBwtzbL3P58huk9UxT
X-Google-Smtp-Source: ADFU+vu2WGm4nDcjQRAQKBwUBgmrZ3C1HCKByL1DDsqYU/OnM7wN7XQHVFwZ5+hwzOYEc0nxXXd5nzjCRDfe863heGI=
X-Received: by 2002:ab0:20a:: with SMTP id 10mr4658237uas.19.1584018543062;
 Thu, 12 Mar 2020 06:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200311080439.13928-1-tiwai@suse.de>
In-Reply-To: <20200311080439.13928-1-tiwai@suse.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 12 Mar 2020 14:08:26 +0100
Message-ID: <CAPDyKFpQCFSX5iRzxHgJ3xXoYzUo7GZs50a6v7YHvkRUTYFE2Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: vub300: Use scnprintf() for avoiding potential
 buffer overflow
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 11 Mar 2020 at 09:04, Takashi Iwai <tiwai@suse.de> wrote:
>
> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/vub300.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index 6ced1b7f642f..4008871bc2ec 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -1363,7 +1363,7 @@ static void download_offload_pseudocode(struct vub300_mmc_host *vub300)
>         int retval;
>         for (n = 0; n < sdio_funcs; n++) {
>                 struct sdio_func *sf = card->sdio_func[n];
> -               l += snprintf(vub300->vub_name + l,
> +               l += scnprintf(vub300->vub_name + l,
>                               sizeof(vub300->vub_name) - l, "_%04X%04X",
>                               sf->vendor, sf->device);
>         }
> --
> 2.16.4
>

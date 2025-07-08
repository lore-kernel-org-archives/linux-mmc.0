Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA22E2672
	for <linux-mmc@vger.kernel.org>; Tue,  8 Jul 2025 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989699; cv=none; b=ug3Bp2+k45yFllovsxLY3F9GD+hw41nOvNpfHXW0lUHjhOLYIMdOVg+P4zywCtXNky6+iza/zQpqtjiP1azv5+JxB+kM382l8oJygYwnIYc9It+zszCR93GGNDbw/8q8tauqEu54uJYz84USRC0HzKS3kccbQe9lL/3LwXZgZzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989699; c=relaxed/simple;
	bh=qLeCx9x+NE4hX1j+RsHDuyZScHbN7BgjRSqpoIdYf8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doMg5oMpf2MTsoHS/2j6cib6MG8TUMxKVoboIWK91r4GGbbIzItO5kH7jtDoEOaS8zx69mOp94tgQiKKohTB2HV3quowZmjNkD+bgV5Ly/CyACse+dKdY3/Yn2uKhH+B9i3fF/PJcdL9UBoSFxZgTdVfPaiQd1pTECae3NCO0Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IC/Rfehh; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IC/Rfehh"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e81749142b3so3644505276.3
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jul 2025 08:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751989695; x=1752594495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qklr2Zh9X6SWAjWGlHUWEDH7pWFNNuYHKmbm1Kh1Thw=;
        b=IC/Rfehhi+SosD9kD7BkGwF6gPPPb3pXHP53sX+YQiwKHHXfeiUv1Z87j5HjKXafbs
         cOqezQIjTCEyGRMBNL9mzqRxjWwePYCe2haOmJVQPBnczndDXTkoccbGLT9YWP1tmsng
         sZEkF4iToiRtghmAKW4EiC0JLsR7JOrmYAYgyL+MjyldILJfVJKxuDummQ+sS5CDCkGW
         XJIJaDm3FcUVbiF5sVTj+Vybkb/+UxN6nXu842nGfzhQ9mTwRyWi+hdcdCDi4nACycH8
         Xcn65054lFHX9PqWbD48uqxeb++PvEZqTN9WsKiXUUFcj8BFCYqxTYPPv436c27RCAfV
         ZYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751989695; x=1752594495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qklr2Zh9X6SWAjWGlHUWEDH7pWFNNuYHKmbm1Kh1Thw=;
        b=u95JGqVqmsM0j9DZkEOWFjFdhiaaE3ougnekYq4FiA8iCmhSPop5yZdptmIrcIZUhU
         7lJoTHOoDl/PYOFvIdaGSs7p+a+boEhq4I4Nn+ruaVKLfy1W3Fq7Y/NVVmb3gh4PXiWK
         U1rNOSG9jiUBazxGfkYL5ZSjZL24Kdwze/dr1FGLVQ0zaCxCZm8Y01EizKNAXZ98zInn
         m2Z4aflOpe7DZUp6qVJ8uTmzm870J8SI3Tk740CFk4mIAu9n3Eb558HkQasKy4EslyQu
         q8pOQDWzCdhLYMfHGp/V9KPiS4BTUKbtpUSWDvo+tzwcyDzDo737mrJSDTddtpRDtIhP
         4DMw==
X-Gm-Message-State: AOJu0Yzj4lz59mTFG7tt7vY8/9wbXnmNsG8OrOCsAmpW9EgGsNEguatj
	SGkx9lEiwgHGiZbnvX0xjVwPoPP+pcGjaYP4PVR3+MG+YFMvACwFvvILru6HtWuGFpD+QT89JJV
	xeFMO8Y14rWFfVY4xVNd30XpajzCWiZtZK+GNW2/vdQ==
X-Gm-Gg: ASbGncvnbqt1PYwApX5OfhKPcxoDSztDRxwr3SoGeEgMPQIBRm84w9DqefEHTDKuUeI
	3diYNv2x5A+CptdgVBZRYd5+DJqHu2KWk8fl9ovOhM2eXdT2WGcVADcOJl4LeHnvquQOM8gnbEp
	Cg7karysuodjPYh8FTo1wdHnwNQSqOsyR2fSDsn/Q25oe7
X-Google-Smtp-Source: AGHT+IHJ2JkBw4MdhgfhWWpTJS7l5p/VVWxebh/7WdPM4CubB1PhaFX2QqFAvYyIyeBV9Ktbf1AL6CIhe/kWfcGR0aY=
X-Received: by 2002:a05:690c:4809:b0:710:d950:e70c with SMTP id
 00721157ae682-717ae118174mr4373687b3.28.1751989695308; Tue, 08 Jul 2025
 08:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619085620.144181-1-avri.altman@sandisk.com> <20250619085620.144181-3-avri.altman@sandisk.com>
In-Reply-To: <20250619085620.144181-3-avri.altman@sandisk.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Jul 2025 17:47:39 +0200
X-Gm-Features: Ac12FXwRMrIVw2pdRW8837eWb3r5j98xDjpQaNeZIC9Tx-bcKNq3RiBG5K7tzR8
Message-ID: <CAPDyKFrbjCi4VdEdeUoVG7wbgwXS2BcOZV4yzh8PiTc_V+rxug@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: sd: Fix and simplify SD card current limit handling
To: Avri Altman <avri.altman@sandisk.com>
Cc: linux-mmc@vger.kernel.org, Sarthak Garg <quic_sartgarg@quicinc.com>, 
	Abraham Bachrach <abe@skydio.com>, Prathamesh Shete <pshete@nvidia.com>, Bibek Basu <bbasu@nvidia.com>, 
	Sagiv Aharonoff <saharonoff@nvidia.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Jun 2025 at 11:04, Avri Altman <avri.altman@sandisk.com> wrote:
>
> The SD spec says: "In UHS-I mode, after selecting one of SDR50, SDR104,
> or DDR50 mode by Function Group 1, host needs to change the Power Limit
> to enable the card to operate in higher performance".
>
> The driver previously determined SD card current limits incorrectly by
> checking capability bits before bus speed was established, and by using
> support bits in function group 4 (bytes 6 & 7) rather than the actual
> current requirement (bytes 0 & 1). This is wrong because the card
> responds for a given bus speed.
>
> This patch queries the card's current requirement after setting the bus
> speed, and uses the reported value to select the appropriate current
> limit.
>
> while at it, remove some unused constants and the misleading comment in
> the code.
>
> Fixes: d9812780a020 ("mmc: sd: limit SD card power limit according to cards capabilities")
> Signed-off-by: Avri Altman <avri.altman@sandisk.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/mmc/core/sd.c    | 36 +++++++++++++-----------------------
>  include/linux/mmc/card.h |  6 ------
>  2 files changed, 13 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index cf92c5b2059a..357edfb910df 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -365,7 +365,6 @@ static int mmc_read_switch(struct mmc_card *card)
>                 card->sw_caps.sd3_bus_mode = status[13];
>                 /* Driver Strengths supported by the card */
>                 card->sw_caps.sd3_drv_type = status[9];
> -               card->sw_caps.sd3_curr_limit = status[7] | status[6] << 8;
>         }
>
>  out:
> @@ -556,7 +555,7 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
>  {
>         int current_limit = SD_SET_CURRENT_LIMIT_200;
>         int err;
> -       u32 max_current;
> +       u32 max_current, card_needs;

Please clarify this by renaming "card_needs" to "card_max_current".

>
>         /*
>          * Current limit switch is only defined for SDR50, SDR104, and DDR50
> @@ -575,33 +574,24 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
>         max_current = sd_get_host_max_current(card->host);

Looking at the implementation of sd_get_host_max_current(), it's very limiting.

For example, if we are using MMC_VDD_34_35 or MMC_VDD_35_36, the
function returns 0. Maybe this is good enough based upon those host
drivers that actually sets host->max_current_180|300|330, but it kind
of looks wrong to me.

I think we should re-work this interface to let us retrieve the
maximum current from the host in a more flexible way. What we are
really looking for is a value in Watt instead, I think. Don't get me
wrong, this deserved it's own standalone patch on top of $subject
patch.

>
>         /*
> -        * We only check host's capability here, if we set a limit that is
> -        * higher than the card's maximum current, the card will be using its
> -        * maximum current, e.g. if the card's maximum current is 300ma, and
> -        * when we set current limit to 200ma, the card will draw 200ma, and
> -        * when we set current limit to 400/600/800ma, the card will draw its
> -        * maximum 300ma from the host.
> -        *
> -        * The above is incorrect: if we try to set a current limit that is
> -        * not supported by the card, the card can rightfully error out the
> -        * attempt, and remain at the default current limit.  This results
> -        * in a 300mA card being limited to 200mA even though the host
> -        * supports 800mA. Failures seen with SanDisk 8GB UHS cards with
> -        * an iMX6 host. --rmk

I think it's important to keep some of the information from above, as
it still stands, if I understand correctly.

> +        * query the card of its maximun current/power consumption given the
> +        * bus speed mode
>          */
> -       if (max_current >= 800 &&
> -           card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_800)
> +       err = mmc_sd_switch(card, 0, 0, card->sd_bus_speed, status);
> +       if (err)
> +               return err;
> +
> +       card_needs = status[1] | status[0] << 8;

Please add a comment on what bits/fields we are parsing for. This
looks like magic to me. :-)

> +
> +       if (max_current >= 800 && card_needs > 600)
>                 current_limit = SD_SET_CURRENT_LIMIT_800;
> -       else if (max_current >= 600 &&
> -                card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_600)
> +       else if (max_current >= 600 && card_needs > 400)
>                 current_limit = SD_SET_CURRENT_LIMIT_600;
> -       else if (max_current >= 400 &&
> -                card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_400)
> +       else if (max_current >= 400 && card_needs > 200)
>                 current_limit = SD_SET_CURRENT_LIMIT_400;
>
>         if (current_limit != SD_SET_CURRENT_LIMIT_200) {
> -               err = mmc_sd_switch(card, SD_SWITCH_SET, 3,
> -                               current_limit, status);
> +               err = mmc_sd_switch(card, SD_SWITCH_SET, 3, current_limit, status);
>                 if (err)
>                         return err;
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index e9e964c20e53..67c1386ca574 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -177,17 +177,11 @@ struct sd_switch_caps {
>  #define SD_DRIVER_TYPE_A       0x02
>  #define SD_DRIVER_TYPE_C       0x04
>  #define SD_DRIVER_TYPE_D       0x08
> -       unsigned int            sd3_curr_limit;
>  #define SD_SET_CURRENT_LIMIT_200       0
>  #define SD_SET_CURRENT_LIMIT_400       1
>  #define SD_SET_CURRENT_LIMIT_600       2
>  #define SD_SET_CURRENT_LIMIT_800       3
>
> -#define SD_MAX_CURRENT_200     (1 << SD_SET_CURRENT_LIMIT_200)
> -#define SD_MAX_CURRENT_400     (1 << SD_SET_CURRENT_LIMIT_400)
> -#define SD_MAX_CURRENT_600     (1 << SD_SET_CURRENT_LIMIT_600)
> -#define SD_MAX_CURRENT_800     (1 << SD_SET_CURRENT_LIMIT_800)
> -
>  #define SD4_SET_POWER_LIMIT_0_72W      0
>  #define SD4_SET_POWER_LIMIT_1_44W      1
>  #define SD4_SET_POWER_LIMIT_2_16W      2
> --
> 2.25.1
>

Finally, it would be nice to have some more information about the test
you have done to verify this. The performance numbers are very
interesting, as it seems like some cards/platforms could really
benefit from this a lot. Would you mind extending the commit message
with some more information about this?

Kind regards
Uffe

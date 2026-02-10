Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E753328B5B
	for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770730491; cv=pass; b=FhNcdfXXKmE4n39Fm/RnoBLzVZ9/d2zRDT6wiBh0xV4SpkVn2yx3cocM2w7u0tjfSAca02kKbd1UnDDROLSXYph3STM9sdDPUQu/cYNZQQJ2V+C6KKpSVZ/+Hw7rS6Seh83qhY7beRcvhijT5mmTLTWCYLVo533Hg2RCSDcUA7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770730491; c=relaxed/simple;
	bh=AdpjSw7dNkdr+/tjYVp8tYBCboA8uj/PFr3NOiu6QnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PH5SXN+iIg4hmLxXOZkAMFaRyWHjKtlYkahtyrD8OP+dkMNzSFL0axt1ObdDhxoAGp2iT7V4N4X99clkeIHzzBdILXsqygd9+I1OHwLWUuHHwfpN6gRFyW77hZEwgg+O0i89l8FWC97hxYn7r96ld0k0KtS1b2ndaQSDYGYtja4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xClPmlTp; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xClPmlTp"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64ad9fabd08so2657286d50.2
        for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 05:34:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770730489; cv=none;
        d=google.com; s=arc-20240605;
        b=aYB9gHLiL4bv72E6pBgbHAics3DsQl9muCZFcd6xoEmSo9oWeubGyJKyWsv/6Yqp+9
         klQebf8le5+BnlG5MmUfluRhXlV8ZQljN+hd8GtFyNl0iNCgVPGPMESa/rgVtVVa1e0k
         xymKX/JPjQWWF9NBe4rZukKfEBb34ckbouYf8qulz1XSxmbo7EwWOYrcmdG5eXj34UXP
         VcpD8DYBcT4Pew7O7Woe5ljaVE4aueLWSXgyqX11CQrk7ZZ0TAhQBxkp/rLhNHvHQopU
         m7vry+cTVstmnaQ1LDFKjFn/4l43+YrkyLerQ4sdT4ZucP+lmpsl0YCEseieXwP5ReU4
         7eDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Awy7xGMtWG+lB2DiLFib9mc4+as+WZ2R0n66soYWbRE=;
        fh=eaujysUDGpfVbLxVCakYH6t6IWNGNANB1Msgb3WCg+o=;
        b=ZA42MuPFjFoYNIw0eaoViIDCjpvmitkNKDfYqV2+GKo55aWNEspzZdKVyDoMQ6iDvD
         1o1qiU53a9VexidtweG/HyJriNksqo4uVXGcO+A627qKnTZbZGYwfNkhXhXwTReonuIu
         zdBsAk1kZDQ8aTHQBfDigcWCFSYJfWdaWy+LRLSlXhiSTx6ardX9vfBiexBd1Ov1zH2B
         D5CTB3J5bZlEh2ETmX11iUoe/A5vjXcTT5wFDYyY8r9K2hawi5/zvuN6+UJuA0yZQUZD
         x3SPNHrNCfFs4mNEEDhS5rZJDj0OWrkX9FZg5/jF7KVcmDxGW/g6AylwMSXWvjd9JlWq
         M7Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770730489; x=1771335289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Awy7xGMtWG+lB2DiLFib9mc4+as+WZ2R0n66soYWbRE=;
        b=xClPmlTpW83778ogu7Eud87AdTFkK5Y4I3tN0m07H8z5/B5dd+cfmFGGyaSSVyrVDi
         tzg+ya1XVE4Pvenqpeg/8oeXjW7X4IyqTr/UKqJO0zse1lvk/OM/HkUfQTEvAaWjoaae
         /ADxiDrH0cDK6FYyrQ/AArhpdTpKVzCPthnM7YY65W8kmBgepquzR5y6cTi9XKq8HWQK
         qMxzVpOc9WQ5FuA0iQc9mGLTM/YW7S0220kmZPsRn4OcnIhyOAPmBX/KhBTlrW9IbUC+
         Dh0YgD4uc6qoNVG++fqfUW2VdaCIryq0Du5K5OqEuHGSWipPPRmcEie1wIhWOuAgLES5
         BraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770730489; x=1771335289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Awy7xGMtWG+lB2DiLFib9mc4+as+WZ2R0n66soYWbRE=;
        b=rVANXC6U2iEV37X7j963othFtAct6GhmK0UyrerKOyTbsfyrjJ0XnhVmpASU/coZHU
         ZtuhQM506sqhjm+DUl7Q7tktttk0Afy2uTg5X3XVkJPc8oI3INKqJerMWGAke4A2bKeQ
         mDC/3auUv8YRxbkawuco50gEh2LL979r46wUcIrL6Vi1yHdpSpVHplyFK/BItx8MNyc1
         nHkOMjc4w//MdBaoxxCrx8LX45IDdhoOfOghDKxT6wEaFlUMDO0e1MoOolcOscTR+ePc
         Ef5Mf5uW3IqmRHlBKPbnwH/83uxipd7ERQQ+BodPYnSTYSaZiTGqVNzxrgMSubr8igdh
         0IjA==
X-Forwarded-Encrypted: i=1; AJvYcCUsKThB6luuNvdqpg//xgo7ZiTjq1D5La7jLZTGOcuCBGu1XDq8qzi6TRKutMaqYJSb/UfDsjrO+YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMlICfw62oAr19t7+6bs45z9NfOMSA/wvqdGWV0eQOA3mX96Wg
	MsJXGitdtWPJss/psDJGOmfbxlSEyA9F5D2ve8Vb0TFP2ZGZvcyL5+7nq0y8giSm8OzZG/R0wsp
	KAgpfhg19mrNhnY5QH22wav+tGB9Uphe7DeeGNdAtHQ==
X-Gm-Gg: AZuq6aL0O5hdMwivLkKJVWN09eJTSTySp7HhiYUIAENPBcAyUTiqnouiffcNOLpNayf
	1/U2zOETcpWyM64U2D+sGCPTXBz1RKl1Z2LBOQgOPlRUNRQhVH4o/D8t9EsCpOet+a1MQBOp7ps
	UC2tDetpoxZ1eDreVjKqXxDz0CoCP5XZJRbU5eoD94zifqMaum9us9mX0f4qfddisKqUXtoD34x
	Uj5BSJ6otXwRGo7iQklSvlMOr366/RMGzTjlNduENZkTTpsoLjZU/RppQqD7t+Dr2zP22NmZp0g
	LTxnOQ2/Y9EaUOyKTik=
X-Received: by 2002:a05:690e:4082:b0:649:f272:4e71 with SMTP id
 956f58d0204a3-64af2194733mr1895375d50.61.1770730489200; Tue, 10 Feb 2026
 05:34:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67c8c4f9bf9f09fd0c13daedef27b82ff389ddfb.1770720452.git.geert+renesas@glider.be>
In-Reply-To: <67c8c4f9bf9f09fd0c13daedef27b82ff389ddfb.1770720452.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Feb 2026 14:34:11 +0100
X-Gm-Features: AZwV_Qh7YZqJ6fn57eqSKDNnShG5y8_vQaT5Jjd2bk1tO-PMV5NbiA4MiAomS4E
Message-ID: <CAPDyKFpY2X8hephSfHq7rj_DaKX76ZSkWSCYXrGTEBUFHkvOzg@mail.gmail.com>
Subject: Re: [PATCH next] phy: renesas: rcar-gen3-usb2: Drop local devm_mux_state_get_optional()
To: Vinod Koul <vkoul@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Josua Mayer <josua@solid-run.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, linux-phy@lists.infradead.org, 
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Feb 2026 at 11:53, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Now the mux core provides devm_mux_state_get_optional():
>
>     drivers/phy/renesas/phy-rcar-gen3-usb2.c:944:1: error: static declara=
tion of =E2=80=98devm_mux_state_get_optional=E2=80=99 follows non-static
>      declaration
>       944 | devm_mux_state_get_optional(struct device *dev, const char *m=
ux_name)
>           | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>     In file included from drivers/phy/renesas/phy-rcar-gen3-usb2.c:20:
>     include/linux/mux/consumer.h:64:19: note: previous declaration of =E2=
=80=98devm_mux_state_get_optional=E2=80=99 with type =E2=80=98struct mux_st=
ate *(struct device *, const char *)=E2=80=99
>        64 | struct mux_state *devm_mux_state_get_optional(struct device *=
dev, const char *mux_name);
>           |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Fix this by dropping the temporary local wrapper.
>
> Fixes: ad314348ceb4fe1f ("mux: Add helper functions for getting optional =
and selected mux-state")
> Fixes: 8bb92fd7a0407792 ("phy: renesas: rcar-gen3-usb2: Use mux-state for=
 phyrst management")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks Geert for helping out!

> ---
>   - ad314348ceb4fe1f is in mmc/next, and a PR has already been sent
>     https://lore.kernel.org/20260209133441.556464-1-ulf.hansson@linaro.or=
g
>   - 8bb92fd7a0407792 is in phy/next

Vinod, do you want to pick up the $subject patch as a fix for 7.0-rc1
or do you prefer me to handle it?

Kind regards
Uffe

> ---
>  drivers/phy/renesas/phy-rcar-gen3-usb2.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renes=
as/phy-rcar-gen3-usb2.c
> index cfc2a8d9028d58d0..65cbf330bd8fa10c 100644
> --- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> @@ -939,16 +939,6 @@ static int rcar_gen3_phy_usb2_vbus_regulator_registe=
r(struct rcar_gen3_chan *cha
>         return rcar_gen3_phy_usb2_vbus_regulator_get_exclusive_enable(cha=
nnel, enable);
>  }
>
> -/* Temporary wrapper until the multiplexer subsystem supports optional m=
uxes */
> -static inline struct mux_state *
> -devm_mux_state_get_optional(struct device *dev, const char *mux_name)
> -{
> -       if (!of_property_present(dev->of_node, "mux-states"))
> -               return NULL;
> -
> -       return devm_mux_state_get(dev, mux_name);
> -}
> -
>  static void rcar_gen3_phy_mux_state_deselect(void *data)
>  {
>         mux_state_deselect(data);
> --
> 2.43.0
>

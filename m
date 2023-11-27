Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a7pYE2aW"
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B671FA3
	for <linux-mmc@vger.kernel.org>; Mon, 27 Nov 2023 06:48:50 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35c690f6e00so10135485ab.1
        for <linux-mmc@vger.kernel.org>; Mon, 27 Nov 2023 06:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701096530; x=1701701330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3FLX3YynhvX8mGBDXZEVUPH4OcHBZ2EUZ4Lk2rEt1c=;
        b=a7pYE2aWifuoFRXSQ6zcnLuYt2Sy2I9bDprPt9EY4fq6088lhrMaYlFdNbO7UdURf7
         svn+etxDHXIcX71dsZOmAVmFQI/zR8dEtVudgIu2SSouRSASnqUJKdMkyh1gVruPU4xV
         NyEX8r06w72PHkJnYM5wZ7EvMOsMlpmXH2KN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701096530; x=1701701330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3FLX3YynhvX8mGBDXZEVUPH4OcHBZ2EUZ4Lk2rEt1c=;
        b=FUpS/doDsenZaRHPGZOZkg9lfdovzT8W+996qyK9u7Ir9BNLeNY2LkBxhy5FOIyCU6
         +RpjJSzHMsse7WERYnrIde7/poT302qgtr9xSY8PU6shRqXjkT/VQefsQ4qGGT+QGGBY
         xtwY78zumpat8jbulPy0GfIbO/X7NqaQzVYF9fUYz0bASU14qNsK75rAuuo19UCY1aBf
         m9NUJ0LLJ4kFIDmKNrhBwhkeXM9UyvChocmBvYAkssEhW1ED/G92go5iPfo7FJoSmTl/
         0wTj4a51I6iFrsodmPrhOwmpVDj1k3VkmiFoBsJf/FUhWxsF8d2zDTFac4IUwPnkmF13
         YwJQ==
X-Gm-Message-State: AOJu0Yz5xVZuS8n0TMCpz7JVYlFTmcXxLOkGrVKMVkN+c/ymxY/NRm1V
	Cxki7ZzIGqNnH2Li7aV34VfAFI1wFV82bemZE7jFtw==
X-Google-Smtp-Source: AGHT+IGcnqezwlGNDh2RQ7YHJ0GhpoAmyujmyGpF9m9aXpMS1mAWqIijhV4vdV0EDPLxT8+wxU+ENK4jUdVRZpXfG9I=
X-Received: by 2002:a05:6e02:20eb:b0:35c:7b32:2425 with SMTP id
 q11-20020a056e0220eb00b0035c7b322425mr11231186ilv.8.1701096530125; Mon, 27
 Nov 2023 06:48:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117095531.1693753-1-treapking@chromium.org> <CAPDyKFqjcP2pAH8uo61Yc7wU76NM1aCMN6P1TaAoafCFfZSeWw@mail.gmail.com>
In-Reply-To: <CAPDyKFqjcP2pAH8uo61Yc7wU76NM1aCMN6P1TaAoafCFfZSeWw@mail.gmail.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Mon, 27 Nov 2023 22:48:39 +0800
Message-ID: <CAEXTbpd7qD4qzY0p3rDD92eTMVCeu+ZsOWBMwJA8cOYe8=JvgA@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: Increase the verbosity of msdc_track_cmd_data
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>, 
	ot_shunxi.zhang@mediatek.corp-partner.google.com, 
	linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Fri, Nov 24, 2023 at 1:13=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Fri, 17 Nov 2023 at 10:55, Pin-yen Lin <treapking@chromium.org> wrote:
> >
> > This log message is necessary for debugging, so enable it by default to
> > debug issues that are hard to reproduce locally.
> >
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> >
> > ---
> >
> >  drivers/mmc/host/mtk-sd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > index 97f7c3d4be6e..4469003f571e 100644
> > --- a/drivers/mmc/host/mtk-sd.c
> > +++ b/drivers/mmc/host/mtk-sd.c
> > @@ -1150,7 +1150,7 @@ static void msdc_recheck_sdio_irq(struct msdc_hos=
t *host)
> >  static void msdc_track_cmd_data(struct msdc_host *host, struct mmc_com=
mand *cmd)
> >  {
> >         if (host->error)
> > -               dev_dbg(host->dev, "%s: cmd=3D%d arg=3D%08X; host->erro=
r=3D0x%08X\n",
> > +               dev_err(host->dev, "%s: cmd=3D%d arg=3D%08X; host->erro=
r=3D0x%08X\n",
> >                         __func__, cmd->opcode, cmd->arg, host->error);
>
> How critical is this? Should we perhaps use a dev_warn instead?

After rechecking the driver, I agree that dev_warn() is probably
enough as the driver tries to reset the hardware to recover from the
bad state when this error happens.

I'll wait a few days before sending out v2 to see if Mediatek people
can confirm this.

Thanks and regards,
Pin-yen
>
> >  }
> >
>
> Kind regards
> Uffe

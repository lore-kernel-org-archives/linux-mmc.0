Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D29154A7CD
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059011; cv=pass; b=gxZOijGcaAK3QAx3s++gMpzuq2qfXXg/47jx22ETdmTnLGcAjs2zbuEB0p/rPo5RX5T+gBfChdF3lJE5D4h8SI+Y6HezZfr+2VLuRywEKqbZDEbk9TxT0gG8jUYE2nBUVomPv9BHv/MiR/j5PMtI3wbj4YCTjAPS/wbshk495LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059011; c=relaxed/simple;
	bh=+HKUJE6P85XJHh4t+ruBGSw/fPns5n/Fki/8ibDdu/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xo6qp946oHPtCbUcJPrgkzNZLPInlSTLDW4kCQP0c6lwW2WN6jm50WP6lGNfhihhxezf3Ta/0W2eRA2MQgZuseCWeguYVh3BoCIK822SB/+lEmeyNoQCs6sugBQPoG65ejUj9JJFYIeuHmYIBAQQdFncz3P3CYeUgIl54IWutpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=nGZq0c7r; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="nGZq0c7r"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-857ff9fef54so72900297b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 09:50:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789059007; cv=none;
        d=google.com; s=arc-20260327;
        b=Xj8oM/4Gb44XOoB0kCgQVsXpcPLREv+hNmOY5c8DPy78ie9BVKoZTda2avwkqEMPUf
         DBAnHR2o49zY3CD7JKecFbYkv27qps3u2k1fS7K5tW0acy6rHZHSZfrkJwNdHCGklDXe
         H4h9Fi4gQInwmVncgO+RGAeCb9s1Lznm3ZKCwtT+yWutswvbqd5IRzP/iCFUwpjQCNvX
         rGilGLrpVJbzuHesOy4JknygKN/PrsPAZywlIfPOffrIyyvS5gQefKpWtOl7BMjcWsvD
         /qokQmQk4UaLJ5QR8ktUrJG8GmeyuH5BRNuwwrU5FnwL28wW9EBcNrSniFP1kBDiQIFF
         sn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xno3TEY+GFXENHJM/t8g6PbysHqcDlXxaL+1MiwWtY8=;
        fh=qZOLFaHyItW6lvxqTw46phLYgnfc51kfNhTlCUvufzw=;
        b=GNv7mKRI7RABhsGxqR7G9Rbxu404iz5Iodx2aiA+ACOk76opstNaI7wSyi9E/Qf9KO
         7+AQM/UHGIUb3vHZE6dZgTAscBNT0Pl9UjXlzdL3nK7Gz6xDQYqBIBSHpPCBxIqeJzrP
         newDnC6+x+jK8pP4O2SPK7WqlwmiOcalHyZ6dpN159F+gQ10qYF78QaRLNVtzDrYyql2
         b8i+V+oqiTnTjcxyBqqCliaBx8yUs+QnvezkoVIhgJZYSJ5GKJJtFT2laTxieWRzxoEw
         z+5qY5SHBK696GoL5WoWzlPDDhaNXSYxoU52HagTDdStjzEydJ1W9WEyoWbVcpzJGPD7
         PiHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1789059007; x=1789663807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xno3TEY+GFXENHJM/t8g6PbysHqcDlXxaL+1MiwWtY8=;
        b=nGZq0c7rsOI31QlSRDtELBMbHS2uGfcU+KY5uItyGhI0HV8Q6gsdD4uYxn8lRTZXcz
         gdFEZL3cqpOeY6EAEXiNGCUqxfZ11ya7G1KeYUbIN9qh7RVS+/Vv4tPhnry29lmkLG5s
         KZDN6GHv9DABpsFtfrm6sroCyOhLcjx3eVMjoMhb5iWeS5P50Hj9b4IlVAIBFFMOem94
         EAzHxA0EpvpJ+DlI5hKTX1QaKEEdNRE1gJkNnoo0BtfyQIpQrdaDewUm39jCQLRmgryu
         Y3pBmWfwgqd0878j8dN7SlfBvqIlZ5cM3HxHQhIVAmXDOnwUusRPSdlknPqU5rmXKYJU
         YKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789059007; x=1789663807;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xno3TEY+GFXENHJM/t8g6PbysHqcDlXxaL+1MiwWtY8=;
        b=NdYmOY0OlO82fwhBqdWiXYL4GMD1WXEbdWKwqv/OGmKxTnWskNyh4vZKRkWLDqUt1y
         +GAKYhS0eWFxz/6HvahsKStSydoH057gDLUNAV78waMiuSwxoXGZ9vR+1dni6a981lJj
         ZHaJQJ6cTUXwpTNXl5tyzwrjzWNQdwpEp+R3IjW16SQWGIk3MHAgnNvEfb1hmi3+ctAW
         AmHD3eeKdGm/G2jY7ZpYY0zLR1wbqwU7bqOtvkfKLdHmisVqmj0KCkcuZl6FozeKfKhg
         S51CNIOzz2istMGSO/UQCIQuG3Bf9wJQabIHnc1LcDZbrquDR0m57pKd1abpcOsZr6jS
         r4yQ==
X-Forwarded-Encrypted: i=1; AKwUvBwVz6vBXQjjVjnxA4kY6bYBe8W4NwX4LvYwi/ygn3qtui251ofNp5g3H1rOkc8vQrQBAuvoIdOZ8r0=@vger.kernel.org
X-Gm-Message-State: AFuF++lSjXOPRcvoUiih39TCSOpilGcIGHdauIzhiICLUBpD20wEinQ0
	bUle6PuuuAJvKa+k+es/fOLEPVCWgBALzKjlLWAnNcV0aljIX4DRELLeBS6s1I/IWmGSM+yvqAk
	fAOfIyMCswBBTnuPhW1CRAT0/It4pPr9GBvczPOq5
X-Gm-Gg: AYBFou1/xaxmBBUIUR+zTy15Z+m5pMAPCfp7xynl89qe9JdvcHJMWx5ZgxSIyIxOYcN
	6jEeeP610rmvFSeFVjw/NnKOW88LcVsMRYfmk/0nSK7AqkpBWMiBSIGcDm7wbk+iszjDH3NJ5+d
	kh0i97mdJOVG20NGQY4SBkP88ptWgjO2zuLhUm7pu4+OGgIyICt4BAF/7KFGbRVhL6X1SOFvkSo
	CVbUY03oFJeeK11/thewlbVGgs6DoH8TAUucqcxSiwY3H7whSFcacGh8WmskiEDo8Ldr7Pm/rIZ
	MCKi2njmg1cBuYblO0mWEq+tK1QdlXICM/k1rbwfYI7KjS8mlXojlHqqd5bURo3WmxKKZ/9WWjs
	sp+6IkPDBow==
X-Received: by 2002:a05:690c:e3c1:b0:865:7a80:36b7 with SMTP id
 00721157ae682-884b2104374mr581967b3.6.1789059007209; Thu, 10 Sep 2026
 09:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <50fc5e8a29e3a5e9a64c64c5f775d758dce39b71.1787603965.git.sean@starlabs.systems>
 <CAPx+jO-TodBfjkJ6SV39LHWyTKDRj=P-Fq-VnfT=kin4VBKkvw@mail.gmail.com>
In-Reply-To: <CAPx+jO-TodBfjkJ6SV39LHWyTKDRj=P-Fq-VnfT=kin4VBKkvw@mail.gmail.com>
From: Sean Rhodes <sean@starlabs.systems>
Date: Thu, 10 Sep 2026 17:49:54 +0100
X-Gm-Features: AcwNN1WAn_D4uG0zFEIPWU8SqL3y7X6o9ipW1UeAOApWdvc1we7lE80s0UDXMUk
Message-ID: <CABtds-2y94frC+4T9nsDzO8oSBE7CjrW20=MrgiTGUoFqZFwaQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx_usb_sdmmc: start card power-up at 3.3V
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Sept 2026 at 17:05, Ulf Hansson <ulf.hansson@oss.qualcomm.com> w=
rote:
>
> On Mon, Aug 24, 2026 at 10:39=E2=80=AFPM Sean Rhodes <sean@starlabs.syste=
ms> wrote:
> >
> > A UHS session can leave the SD pads and SD18 regulator configured for
> > 1.8V. The power-off path disables card power and suspends the regulator=
,
> > but does not restore their voltage selection.
> >
> > On the next power-up, this stale state remains until after the MMC core
> > requests its initial signal voltage. Restore the SD pads and SD18 regul=
ator
> > to 3.3V before enabling card power, as the old rts5139 driver did.
> >
> > Tested: StarLite ADL with an RTS5129 tray reader; repeated 1.8V UHS
> >         sessions, power cycles, and tray removal/reinsertion.
> > Tested: StarFighter MTL with an RTS5129 trayless reader; repeated 1.8V
> >         UHS sessions, power cycles, and card removal/reinsertion.
> > Tested: Both systems re-enumerated the card after every cycle.
> >
> > Signed-off-by: Sean Rhodes <sean@starlabs.systems>
>
> Applied for next (or should this be a fix and tagged for stable?), thanks=
!

Definitely a fix; did I miss something there?

Thanks

>
> Kind regards
> Uffe
>
>
> > ---
> >  drivers/mmc/host/rtsx_usb_sdmmc.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_=
usb_sdmmc.c
> > index bf37fab233cf..d9b33aa79165 100644
> > --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> > +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> > @@ -980,6 +980,11 @@ static int sd_power_on(struct rtsx_usb_sdmmc *host=
)
> >         }
> >         dev_dbg(sdmmc_dev(host), "%s\n", __func__);
> >         rtsx_usb_init_cmd(ucr);
> > +       /* Start SD init at 3.3V, like the old rts5139 driver. */
> > +       rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_PAD_CTL,
> > +                        SD_IO_USING_1V8, SD_IO_USING_3V3);
> > +       rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, LDO_POWER_CFG,
> > +                        TUNE_SD18_MASK, TUNE_SD18_3V3);
> >         rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_SELECT, 0x07, SD_MOD_=
SEL);
> >         rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_SHARE_MODE,
> >                         CARD_SHARE_MASK, CARD_SHARE_SD);

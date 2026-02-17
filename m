Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A7D2D949F
	for <linux-mmc@vger.kernel.org>; Tue, 17 Feb 2026 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771319009; cv=pass; b=QG//rGJ8wvNE9Pk0E6ILsDUI7PBk0C88HIc5iCSI/omwT2PH25MHP2zI3/Nwydrayf9GfWNxosmm0z4241CCGOtlkca0VJA5jMj6obSkS4RjOYcTQhWa8AZkmM7i1IIRhvYO4RVOSD85YXtqdZE2F8J0yOG+OKQVBluueOPHGjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771319009; c=relaxed/simple;
	bh=v5EoAdPTQfqXTcoEvCiQDaYYtk4+qlcwUAwcrKadu1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxJP3JW2wUX59l7EXQ1g3H26dqXb0UnMUK1og0Jak9Imiv+vzdw/m/foTeNYm1KUsepc+0YWGUEEx2uaoxfmXj+G4m+UHB7pZLBSiOL/yXqzWrT/1bMjjp3WTmPDsNNYB4wcVgqErcMFsAQq3RAwCkmn6lbHM0D5g5OrinukM38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sJyxvR8D; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sJyxvR8D"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59e65b8e268so3641439e87.2
        for <linux-mmc@vger.kernel.org>; Tue, 17 Feb 2026 01:03:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771319007; cv=none;
        d=google.com; s=arc-20240605;
        b=UIww9e+99T2Y/d+oNja8VJA5W6/1/yhB4tEBYXOIgbi/nnBocxo/TYXc3D0PEq0tLv
         GtwhNR51jY8g3B4AzBfs+QbgR7u9vycRrD4VR8afqDhPsRqtSy9j5ShKs6iHJB9B6UEI
         FaNNYHBU85VoRechiKnaJftL9kj7oluwtdKUMEFKW997YPoiUWaRjsJg+Zd9d07Y5dya
         vO3Z5TUdXTgMgKCp8j8n0aTszhEry43O4fOemfTmbDUb9N4u6K7NaFo0DQ2XD/Gtr+EK
         6RJN6HGHP5EpXORQPjWuWX4NN0p4nK4xkrkZcFsnilS5aj028yLQnLu96103oIQKg9wM
         yJww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RoxFTC0oUorf76Kf6dX+GhEcbA32G2mdakarqzc/Cv0=;
        fh=jSR2SMmwAPRyGd7qX/6ieaKbiPhlfv5jaKLhtZxzwB4=;
        b=LzO+7iN56ywXaMReU2FqLWakOeR6IxuseXJcguPgSZmk+w86y043KbmaMxDv5q6iay
         MaWJrNn70GFcBQtD0YHpefzdcaHpo0R9vFs0xl/M1PZo3o8hWuNXfHw6se2gkjeHOUHH
         JDKbfaSkzB1l8qzcXPyOm9t81L9b/3r8zLEYbz2m5B+bIF+vv9wBLB5jh7UYwkpuHe5t
         yh6GfBQ973u8OJRy2ZvTFXcmn/rK5rWdAsB0zE33O4xF6VkUfDM/hnVPAsxCqBy/B7Ot
         k2ZAE5EImFGxCPSKap1+a0d4zo15btXBRRSzPpNBNe+5LQT3LP38AlhO3hTqs0pKNF+U
         SO0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771319007; x=1771923807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoxFTC0oUorf76Kf6dX+GhEcbA32G2mdakarqzc/Cv0=;
        b=sJyxvR8DO88JiKK3LbIBBKuCsL/XTXLBQ5nLdxnlEKi4EEvOspSRYo7ma9JxNLbhva
         oZGZy0eZM/q75xQLx3PFt5XTFN+/rUy4oP8x3GeMd/+8ktLw3uvZyg0gfVSo3tsovbr4
         ZxSGRvMFrNWGkDXE5uZSP+SuJP8yLT+uIazV410dvXV1QykZAASy85vH2m3/hiwbC+Le
         jXH7oK0yF+d0SasgaMFyDVJWIgGi89B37oWZsS1qGPQLl9y2JJHRtQ9qMrJTjVDP5sFb
         jYzvPg8RE6wT2GGLSnB0dtL1LO0boGj3lt9HnfINL2hMtEawmkOc657E0HeOPfGNv5u4
         e49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771319007; x=1771923807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RoxFTC0oUorf76Kf6dX+GhEcbA32G2mdakarqzc/Cv0=;
        b=bQ2eLX7A0HjR2bItoMa8EGwoQ7S+jk9n6DwhxUMu4t++Oel9wE+F0XOqtjLghaziFO
         u1k7jfk97dRKpQ/XeF7n3rvdjVrRbpQZVQ6rOhRE50fUmTxLjitnkJ0BWCLsnMKrRy9h
         +EKV3tKQAl818p3g6BF65LUbfQ+c2m1O4OFOGpDIWEDhbVXaiHIgcMhlBu8IMUfj1WxR
         6+mR8m5J4dR/T6EfEKI3ti2aiD+TSut7kPpzwqcp3RqLU/dmnvMnGuTR0KJtTIy7lbO/
         aVe7BLWdRyIQzQUxu/dV92hG0hvPWQTcHvliH3HnLyFRAZ9AOpJagZQTdmoXJOYExPJ7
         pPHQ==
X-Gm-Message-State: AOJu0Yx2+WWGBalvSkd8fluMj+nDFJwF9f9OD5Zrms9EUhCVz+0wz3B5
	+zxn3ezalIHDq+UyHof28n13nuR/OR0VpXTG5/4ijgXoAM/Z73p63R1leAFQykrOkYdsO+IkGBp
	hP43iokkw1a6Nj39nWPL1sSynzaX5BNlK5i4jMb0Ziw==
X-Gm-Gg: AZuq6aKvkQcPcPvqPZ2ictg8OYY/JNjwgl08qB48DvMstW0f5uC2nvhmCz0O0qOBS9y
	yB2om3583uV/KrcsCRZ1FPUF3ydTP7ToxTj6wm6vUTagnLDEhmFOiK6a9mmTr5EnMcXoTxppoOh
	3fuzqTU9/akNXJ3GcU9N7UbsPvd7Ibbn9ns8kBpStGDlLpSpevvFsvygdN68ohLAoPaIANenHlg
	DSVxuiJBjpP7GVJcYK8QaDgWwJYbb1XTTYS+U0UUroEEOm7+gVB/fTUz2OKLsQQAEA8F8l6OvCb
	vhpusThK
X-Received: by 2002:a05:6512:686:b0:59d:f71b:3608 with SMTP id
 2adb3069b0e04-59f02632deamr4608618e87.31.1771319006245; Tue, 17 Feb 2026
 01:03:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209133441.556464-1-ulf.hansson@linaro.org>
 <CAHk-=wgnRQiKqWVrO_uF1btYM2K8r8xL95RGdKU3QLe8B58nrw@mail.gmail.com> <CAPDyKFrFez=tDXLqRmeS1qpnVMCUPi8POjYkbRGiwAhcT3shfA@mail.gmail.com>
In-Reply-To: <CAPDyKFrFez=tDXLqRmeS1qpnVMCUPi8POjYkbRGiwAhcT3shfA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 17 Feb 2026 10:02:49 +0100
X-Gm-Features: AaiRm53KmI70BKbWNw9Xq3JvVR9m-mRxjNHBlBG5QN2KQr0qJYRa5NdW_h5SmgE
Message-ID: <CAPDyKFrO2HGMeyg6+UKseU2T3b0+yLBdo1y0O3Teo8zk0rC5rQ@mail.gmail.com>
Subject: Re: [GIT PULL] MMC updates for v7.0
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Feb 2026 at 22:29, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 11 Feb 2026 at 19:32, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Mon, 9 Feb 2026 at 05:34, Ulf Hansson <ulf.hansson@linaro.org> wrote=
:
> > >
> > > Note that, this time I have picked up some changes to improve the mux=
 subsystem
> > > and those are part of this pull-request, as these changes are require=
d for mmc.
> >
> > No.
> >
> > Those changes are complete garbage and don't even compile. It has
> > apparently never been in linux-next or been build-tested in any way.
> >
> > When CONFIG_MULTIPLEXER=3Dm, we build that core.o file
> >
> >    obj-$(CONFIG_MULTIPLEXER)  +=3D mux-core.o
> >
> > but in include/linux/mux/consumer.h you have
> >
> >    #ifdef CONFIG_MULTIPLEXER
> >
> > which won't be true (because what will be defined is
> > CONFIG_MULTIPLEXER_MODULE), so then you get a long stream of things
> > like
> >
> >   drivers/mux/core.c:312:14: error: redefinition of =E2=80=98mux_contro=
l_states=E2=80=99
> >
> > because the mux/consumer.h header will have defined the dummy wrapper f=
unction.
> >
> > In other words, that commit ad314348ceb4 ("mux: Add helper functions
> > for getting optional and selected mux-state") is pure unadulterated
> > untested garbage.
> >
> > I do not want to see a "fixed" pull request from you. This was
> > entirely unacceptable, and I will not be pulling anything more from
> > you this merge window.
> >
> > Stop sending me untested crap that hasn't been in linux-next and
> > doesn't even pass the most cursory smell test.
> >
> > You can try again for 7.1, but only if it has been actually in
> > linux-next and properly tested.
>
> Hi Linus,
>
> Sorry for the mess!
>
> I queued up the mux patches on Wed 4th last week (which is certainly a
> stretch that is unusual for me), but they did not reach linux-next for
> some reason, which I should have paid attention to. So, I simply
> trusted the build boots not reporting any errors to me, believing
> everything was fine.

FYI, this turned out to be a really silly issue on my end. My old
email filter was tagging emails from Stephen and simply didn't catch
the build error-report from Mark the 5th.

I thought it was important to share this, as the above reply from me
kind of indicated that there was a hiccup with the integration of my
mmc tree in linux-next, while there certainly isn't. Mark rightfully
throwed away my latest next branch, because it was broken.

That said, my other pull-request for pmdomain [1] should be perfectly
fine for you to pull, it's been tested thoroughly in linux-next, but I
fully understand if you rather not at this point.

[...]

Kind regards
Uffe

[1]
[GIT PULL] pmdomain updates for v7.0
https://lore.kernel.org/all/20260209124757.554032-1-ulf.hansson@linaro.org/

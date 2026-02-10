Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0214D27E074
	for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 13:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770728715; cv=pass; b=UDohCjfKbbSoKfwxd/3pFBirVh41OKIaQmGJuFhSqbh7FC9nYxFeOnjK3SWrGf+xN/aH3TWZLoMA7vVmbDhQPnliEtmauuyc2inFkJHtwV4SmDikpoSt6lRARQ1n9mQP0BcVnb9YBPJGCyrkxRfTQ5MP/4mLKqUHUGuG/h5GdoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770728715; c=relaxed/simple;
	bh=dSnUJA3+yHZ/FYLf6h1sLv4QGMAR4RIhE/hIaBv2kww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FdbSYfvqMfQE+ouM9Qi/ze+CR7yRlz6cNfHNa/0XGQE5ZhLrWqYCPLotgzJ/JE4ipedSOd8qn8HcT0yhAOUZmbVps//8Soj18Jv77EZzJsTJmlcjC1CKnKBfQSa+b2u9udhsroKp0Fu8gXOJ0GIsEiBDTgaAuNgJwWk1/mRA8lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=osht1QX4; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="osht1QX4"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c59bce68a1so56677985a.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 05:05:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770728713; cv=none;
        d=google.com; s=arc-20240605;
        b=fKIzq1p/6fhf/cJqvo6u8xCxdFPS1wBOC7wn9elal5Z7RVzIC7QugXZEG+ra/63IEM
         VJKH6PIefwig6+8i4PPb+JLkHCTfu/MuQzAPpD9RcWgMcJcjpMTzQyVu90nU1OxK5jqy
         oefgZAHxrUIW+aBuFkST08buU4b6UCGCvkxyKXsa+XFr+CJbjNLI0XcJsTde62+LZDJy
         /0+DF+VhlYKmyni35emBt7JcDqQ9U7GEGDav9W5r5VmSWGLABjV/TLsORnVGsW4i430v
         oYIjaQ2OEDpN36VIc7snBVexOkriv73PfyRkJihjRPNouqHIO3j5yCYQKfc4cthAVc0g
         WDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dSnUJA3+yHZ/FYLf6h1sLv4QGMAR4RIhE/hIaBv2kww=;
        fh=2iKz3AqYxwGck4acAtQJ6/208mwqzO+86tu6uoAL4Eg=;
        b=LapYm4V2yYwDkax2iNchV86g0UzWT5PZmV02VzIWEJZJ1Dz5wOVwLhzMzJiSN3YISm
         m+naUiVoc8/cHoTMnZWIqY0RnwQUH9dVjwBwQdD3nx8c6ENZfd2oM4UK0dpqJgbmcYoB
         0ClyFpMYPSpaytF1HQZITKNqgYEDDW22dXzUoxeZK9o2JXZY8uM5brgcnF0eMGZhASwO
         NAHBLSaEfDJDyDiOYMnoCtg/zza+Wv0edvZOFtwN0wge9a4jApVC5VzpZ1o7Z935/VDL
         3mzt3Jt+pLJiOl2+HrW5Hy62XoCl3jV6jJnrDZ1wavCra0yl10mFZmJeWhO1bs9XzngR
         XU0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770728713; x=1771333513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSnUJA3+yHZ/FYLf6h1sLv4QGMAR4RIhE/hIaBv2kww=;
        b=osht1QX4FhlsA7if+s0SmUErLog7jzd32ainuMMorfSWCj2xjOUOLluDRTOwNwJ7dI
         4lqqqq8FgiqedLl4Q3OIs/9xirpKI00DndxFJhd1kEPdMRwRBZHKBIUm/PKz4TmwqxQT
         qN/KcTywKdPqLuMNYPcqoWq+Xzba3BiLRiTmQgyrWwOkSud8u30H8Sw6rFKwbgWVxVA5
         tdFyQX/8iWMT+GuPctMaU7HIh8Z/8cdZYsrWPUDjycmTc0hBgN9HfV1/8/XxFV6+R7LW
         o0MhBW1YDd3s801c4oI3y5jVHFxeCgpPt0zEzWcDh4dyQGItztPRstH2fOasaeKdOtsl
         kxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770728713; x=1771333513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dSnUJA3+yHZ/FYLf6h1sLv4QGMAR4RIhE/hIaBv2kww=;
        b=PJVzIvDzG45pNS10t0i0DsRiQ25j7khHKuElgsDnUGFPDjo6X/Q+h50LJmErhwXC21
         sf3PLkix7p66mqQqhizcIKRX8bfxmmu2DBfWTTVFPUmXF96EfZ3QRTYWrKZxz8LEXZOj
         vU13JuK4CWRXfDMfTei3FlDma/NFB/jsmOta7yaEU+Nr1iYEBSpY4X/Ej60+a+sobOtK
         maWjVgK9/jCRpnRQiM25atT0JnlrGZXwGMeYbiXcjTeZz+Yv0ngn/gsQBK9v6pvP3CL5
         5PENKx81P4D6v7POhLhu4E52vYb25BPAo2PpoJZDz3l3TNSsKEBb8SIWPCKbrpzlRK/C
         OWTQ==
X-Gm-Message-State: AOJu0YySrOAGRR9AQNn0vvMGAfgSP7I4OHqYfHgwbdCCoBSK4ze8pVUa
	ozaIb1BzK+lDD/ULaB84K/LW2YAIcX2MQM4SFN/+4NE6SY5DdhEag80n80ELluog2AaavnS4iyK
	mn2H4Ivfu2Q99aM4DCAQgks83+cfrLn7MfI7a4djItQ==
X-Gm-Gg: AZuq6aIgeuUGEFse76eddq7eZpdqNaDsbf5wq7KB94UyG06A3StGKV7a/FIeYeDaMiq
	IccbkpZNbhkEBVhNpcn84zt8TC+05UdomC5y9hV3LzdDus1vwMBd9564oXKcpMZzHlQnrx7+3L1
	ZEpeyNUjWN+FE7get/vopeHU8mvadmwuA8vuyI6bqSEMK36TGEK/zYM0JpxeKI9cvNBm41YPC0P
	g5ij/FeJhauDLENHEzfmNfmAyO1gKaGOdRqPYXhjzUGH8fLtyPTUErQ+ZBtiYyInUyRyXSauN5i
	1m8ozv+M
X-Received: by 2002:a05:620a:29cc:b0:8c0:e5ac:af12 with SMTP id
 af79cd13be357-8caeeb50fa0mr2024634985a.5.1770728712674; Tue, 10 Feb 2026
 05:05:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131020039.45966-1-enelsonmoore@gmail.com>
 <CAPDyKFps1oX=aKuUYFbXNQXM3rGtZOwTfgCaiHgDvGOb3qGc5w@mail.gmail.com>
 <CADkSEUhk1TfJXvLYOrx0OvVCgCA=L+CEZXGzQAhdTgkKz3a=bw@mail.gmail.com>
 <CAPDyKFrfXgCZJtFHttA1E0Tn1tSugHWsSfZvP1RAOOx5=ViWQw@mail.gmail.com> <CADkSEUj1TsZLXNO-GPU-5c19RPV-9d8os9HnxVOxrygvyTtqJg@mail.gmail.com>
In-Reply-To: <CADkSEUj1TsZLXNO-GPU-5c19RPV-9d8os9HnxVOxrygvyTtqJg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Feb 2026 14:04:33 +0100
X-Gm-Features: AZwV_QhfvEvh9N5jfSGMRrxI1aETXJw7zL9vey9hTy8fsc81MxpQyFP0Q3u5_4w
Message-ID: <CAPDyKFrxNM81N=_jvkLtkzjgnbWKJ9CE8a-3DUrRoZkJoNNQ8A@mail.gmail.com>
Subject: Re: [PATCH] mmc: remove unnecessary module_init/exit functions
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Feb 2026 at 03:25, Ethan Nelson-Moore <enelsonmoore@gmail.com> w=
rote:
>
> Hi, Uffe,
>
> On Tue, Feb 3, 2026 at 3:16=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> > > - They have neither init nor exit functions
> >
> > I don't think that's correct. At least this is my understanding of how
> > this works.
>
> Yes, it is correct. You can easily verify it - for example,
> drivers/net/mii.c has neither init nor exit functions, but you can
> still freely run "rmmod mii", assuming you don't have anything loaded
> that uses it.

That doesn't mean that module will be unloaded, as far as I understand.

If there is no exit function, the module will stick around in memory.

Kind regards
Uffe

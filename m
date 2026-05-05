Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7A72D9EFB
	for <linux-mmc@vger.kernel.org>; Tue,  5 May 2026 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985375; cv=pass; b=NNWsrMkIiRMfKwx+FMDlSl4rwKttkC9NDlAksOVEM90Z6Fsv+q6HH5O7RAliVFqArBuh13h6rtfaJY5CYfsRJOcc42UAgbJqQHJIWkEm8qFQnOefwa+FVg81PpGxkTHaZ4+z/SN+Dc6+5hWZwenl3fyJMYeCcFHAAa0aKV+vjzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985375; c=relaxed/simple;
	bh=7b0U1E4s4ALvgVaIC+1Lxa7P/0nTkadgkURBS+6SzFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pm/GwLXksqPt0U0CXTkXKgpZaO2vO+0WDq0eELBm0jZcDHh/r3StG7xXxcMC9PFzpfGCSk2qL3wCBsgPNOgiFghvWmFkFBVJIGEc/+EG0rZqEYz96AxibzlV0ILpqbUChsxxFtLQ15w8sDCQY3vJdUJUqIO8YKMOGRm0SebAyMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eil2a9wd; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eil2a9wd"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67cd93d8affso723157a12.2
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2026 05:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777985372; cv=none;
        d=google.com; s=arc-20240605;
        b=Y9c+wEFqlxnoli2TS7DdDz3sSdAF2WqjukhIiOPTI8/EfiMDEXhgLWgJOG9XLKKz8j
         lFeHai+hDX9fXGnnRjNAT+dPBR1l+z5coVT0AEn6hsTnwJIsgD3Ku+VFvpwNkFxSXyN0
         qL/JxvuYOKA81e/B6/J2lncxhM2VjZW94EoI5z7pMmOmi1wAP7nbNcA7E3lfJ6C3XpBz
         9RJWqtVuQkR33slzzoFuPxOZazCKMP3IwwvpDKUzczxWOKsWEUW81d2nWjUg/dFpwpCQ
         H9m3NQyk1SJrsr+RCx8wXSISkF8zxRffW580Zz5+VwIlAJjr5u3FfS/AhR27ZnMW6GTn
         l+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7b0U1E4s4ALvgVaIC+1Lxa7P/0nTkadgkURBS+6SzFM=;
        fh=jgIiXa8/j4pA7KQQ8wua+yMUZqrYvn8uOEoDbtawTdY=;
        b=bX7ikVctp6gA7MdhMd0vYrZWPVgDTaG0ggZ+TyW2Et2tldmos7VjwLcYqP2iB8gKqX
         u+u1iQnPWf3UX0Zr7uwBqttccmCUUIeVW/A4Ytbhx4GBDyKB0uPnrKx/Ki2kleNQp/7z
         K1oI1lulLdkBmcMUn+757b4RzEtud4OwSH1sivBRg0at10aI5zSkWfiVfeItmukO8rYy
         kZtfm/xQ8rPV/VkXAsLO6nTUM7MaOKQU9NOxU8dmn6Z9WEL9y34fyvFd/Qez6vBhU5Uw
         Y7gvvCzFWImRTh+pPpiAOE5atiDL8cubDhKpBBHaB/82j6R1l0vPojdACLLE9zatxQPY
         8c4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777985372; x=1778590172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7b0U1E4s4ALvgVaIC+1Lxa7P/0nTkadgkURBS+6SzFM=;
        b=eil2a9wd19Rwdbv1jahKHm1UGDKjzy3SloLB8dLnQzpFzo3CSXVrrujv0CASSOgO0T
         405snIuEMtR26Kxo7UqUPuZh5ry3lb401kEEoGecg/DncjwMSzbEe1ykpso9An/j0vSa
         6VbA7dU5nTJtxMEuIWLUGLs5HttrrEHptRrXUZKxQtKBo2iFha9+s+NaTY1Qd13yfzVZ
         YXgrpuFZUOwLFyZ3X6jZcnVjBOYasoPn4UfKlEmlmXc0Nj8kuJo7UPZwQI14/wOhOZAm
         4WDaBd2bg+j+5tkR4aPIpdy5NtxPwPdsufMMsrFCKO5QHqq5BVlik3Afpnx1E4TFCiTW
         QE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777985372; x=1778590172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7b0U1E4s4ALvgVaIC+1Lxa7P/0nTkadgkURBS+6SzFM=;
        b=qLa5WJaeRDcDmWiI9MQZ145txtdxWzSO6lghOxp4DnVRAQF0T36rkPiSCVuoLnndq6
         oafd8oGUkP8YIztX86bI38yQ5DLOnRPLIgNIb8CKMkpPAsiRTXRzQX9wa/PjOsjYujwL
         lEm+tvaFW0sg/T+A16YXEyLkV+lBHpHiqoix/wfWGaUM9uD7C1Ljr0zyRRC44b+5J/ue
         40Qp+27AATa28xprjDftEcExVqjqsWc7OoKLTcg5FiKFZaw6Xl5pAT3x+d2No/FYrIzj
         +fN9D80KVpWobXw4h7nLqfCWjLALun19eG/DbsdpjX6OoIkExJU0LFk8GgnRuCIOg9wG
         lfGw==
X-Forwarded-Encrypted: i=1; AFNElJ/CZbdTm0nc1OWVFozE4uF3Rf12lt0q1WJtxRFcbd+olJRC5l1UO4aXyidCyzPBuTEwwAhfOON+YyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGs8m9gSoHRUU1R2hRqa3LWRYGyMOnxjPBEbIgICIbtnOUzf2O
	iIgBiopSXkoV46JGBjbmvAnhcbtyVoHPTCotDuN4trrub5M+XAP58tCh9XTSPwRwEgOIwB3JaXO
	cjJQBSOeuncbEb5Zkd373kiDmTF7iPzE=
X-Gm-Gg: AeBDietpEnuJikJOIFt+YJQOKiPjlp+liDjfo5VrXbdtuuvqZDXecaBpxh5s1Q0OOyB
	3Ag8VLo4wwsyIMfHcs69xw33bZvZdWQpQ+U+UaWcWReguLCpjbkOnCspCrbyEPB5zKF8Kylg0/p
	V+yHjYcEPBdRLQ9Q7bkCltf5FA90ycGsn+0JTc+PXdFL+L4aoGh8aXOa/AoweInz6Ao9eOVYLfD
	mVStk+IAklsFL9cIX00AOwUU8vlRoHWYhhCF82teUWcGB//INtI34uweab5YEPdGgOUE5Zk4+gf
	QvBAXHhK54u88F42AzE=
X-Received: by 2002:aa7:cfd7:0:b0:670:64fd:2301 with SMTP id
 4fb4d7f45d1cf-67c1a7b5659mr5300557a12.15.1777985372163; Tue, 05 May 2026
 05:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415123411.437450-1-a.shimko.dev@gmail.com>
 <ad-mCsvOWWgqt-rc@ashevche-desk.local> <CAOPX747KM+Ct8Edj__ng4GMeLvjnyaBG1T2h54LSr=SFgQcuqQ@mail.gmail.com>
 <53c62677-2185-4cac-aba8-09363d0ce9c8@intel.com> <CAOPX746c1N1vsibTMW8KLJoi7BzZXuQj+yCUgApagLwmOMt9TQ@mail.gmail.com>
 <39db3c9d-e2f8-4018-93b8-5a97b5119d19@intel.com>
In-Reply-To: <39db3c9d-e2f8-4018-93b8-5a97b5119d19@intel.com>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Tue, 5 May 2026 15:49:20 +0300
X-Gm-Features: AVHnY4IG9djg1i1uXrcfWw93-gP1Hf2u4CwUIdZ6LZKGf7jyYJItKtrIOGgQ6dc
Message-ID: <CAOPX747hrWxnCmEH4Stne7CcFpntF7PeRLVFtBufp=nT96wwyQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: add reset control support in suspend/resume
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jisheng.Zhang@synaptics.com, 
	hehuan1@eswincomputing.com, yifeng.zhao@rock-chips.com, 
	Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Tue, May 5, 2026 at 3:37=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:

> Sounds fine

Great! Let me send v2.

Thank you.

Regards,
Artem

Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B0037883D
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056612; cv=pass; b=cluFXAK/aq3ZAbkk01T4m4zjgMSljKxJch/sdg51sOmRMEFCwVDS/OZFSMTF+XraOXGZxSP3IWjbCXiQRxsS4xMMdyagfBPxLSok7mbIJ5HV6G6wmFoLZaF3sFdD8S5Qp4nB2YMvh+UxpDoDMUzB09JQ1RpXLl3qftyvF6aSQz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056612; c=relaxed/simple;
	bh=w6iaHf8UDR53XUfjMn4PZzqb5sKYr0Mydb5YGGgW3k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSKXkA9t7GAUuVvjgwSSfRfzkL0fikXY1Wsl8Fxdsw0MELZ6nLUoQFJEDECYEwasaTrpKeoKFH6Dqsa+LwMcYgO630Z3j/oCIoxRdLLkxbZxOj8mQgByG1dsJ+3KnX7YGAtMW38bjDC+VgoJOiW9Dqso8unz3Xkn0Xm9z2FXN24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pOlZ3Nnf; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pOlZ3Nnf"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a13d1c6f25so2619580e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 04:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773056609; cv=none;
        d=google.com; s=arc-20240605;
        b=AtdtEaegkMWB2M8v/YEl0+YKCE6DIiQ3pm2m/T2FhWns/5SL7i6itY76O6CHPi829R
         kBD05FBDrxsgDuiTM+G6xZgXXfOWVwEo0N95ReOgT4C6LPmaTUA01U57yhwrLCuCre1j
         OtXVTa5W/ssI1ydkkYi4mPq2PtYzYOLjnnwFw9hHLRolKm7dbM7s27qiNZg1to75oBEt
         iAZP5FhbMwzcXMNpLPVRGvUW/YrBZcCwxDvRvkr6CujICGoPcvBmq5aVetr+bHYa3Rae
         u5SjUZ8bh0JksYVnvKnNuWUSOzBXeiFXXz0gqwwqpyLnh9ekZ5XlIUTiJwx3+RVuC8AV
         E4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=i09VdkoIIHqjMn455zcfVkUsTgPQeH5bQR1xR7thaX0=;
        fh=dmy6u3WrvBWEcPkBRsBgpFWRLw/uWrPePJRBnVXnh7s=;
        b=Fzr/jq0zbhAxwYXxRG9vPLKtnD9m0fGCYKiICK/+e++3SQdJBPG7dUUgAKUNDnlXPk
         TbMc48kk4WbgJXXjpCq3qNYswIExNhZ1gWPgzPC6rZPXCPQPS/OOMnPLBUzz41a4YGGA
         3p8grnleuul3q9I5iTuOfRz5Lc34iypVPLSqZcaDPDmxdTb/7q9Xc5hlUFl1JSH+Rtr7
         QjeeZX48ju2mnYe2FHpwN0GHX3gNxgpA4+vSMyV3TMS4pUnt80iice0nwuvUdchBx7nT
         ZCMp4iA31Sc2ocF00xl+It7bF3cTq27ro7pEa9Zzrehgzyi+xYBEQfYzDi7oGUtyjI17
         gOpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773056609; x=1773661409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i09VdkoIIHqjMn455zcfVkUsTgPQeH5bQR1xR7thaX0=;
        b=pOlZ3Nnf0nv74+VWfDmE3qB4dL+/BMA8yvBHP9+gJOq/Jv+kzIPZaV/FJS2EqR1MMJ
         QOV6FOLpw4hAtxXEGdyTZ8m+m7ni8iJgZK9GzUw6LBNUXtLML/kvz5pFk02IGMRJSWDd
         0MMp9NX+tWbTQUZ/Jw4v2G5fxMa8PWJqQpG6H4VJ9PnYa+kzD3G2b6VF32kcThjHZ6Z7
         AvL4WdT8HfYJBibDNk7tj+dWbE2k+0o5kL9+uuXQUreFyrjGwgcWGnjgYUhcjFp6+Zr1
         UGBpWp8TriNeDOgqKwt4nWER7Z7L7TDoEKLVIMvdrinaBC8AHRWvEhib62fcU3yzPTIL
         DTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773056609; x=1773661409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i09VdkoIIHqjMn455zcfVkUsTgPQeH5bQR1xR7thaX0=;
        b=lO9sF2hiFvSEMPDPMzgUYZcZ6EidUXLC5dxu45ZGc+ECvLloeeLCcYIMFJCv7lrDAE
         /uzmwqUvS5FpYXLaebE0WbntxrAsKzsJ/LUQVlRG8hIKRX6yrNbAdwUeohkE4ScNUhwh
         Ozdf/nyY/II7djhCLULt+ZyjdIv3T5LtdwRbJv5Qg8IMa+vkPoQRT09jr3JhnuDtC6KG
         MHrwyPjmEpU9ExA9f6P5J69MBk1SPFzJ+Kg96KMySxp5sW2M74J/b8XHCV6hWyw34Qed
         6FzlM/OXXBtpaYOh27dYK98B03ZMkXfsFHUzi467VvJ2IXGh2b7ajz3BteX9vpUjQGhe
         DsKA==
X-Gm-Message-State: AOJu0Yx69XUBT/VPSRkpCiY0nwjUgoL966iqh3FlmAEMaUAdFYg/9bOA
	W9ygnDgdSROgjieLeWXbNJmkkz0LYKMinGdcKHUpBTqSqL1yGAPQ6dssJdbRiUn4pQrMJAnEh0i
	cfO0JmFM9u6r9F/0TmG3HtgYgLWVLn4dmKdAmsuFF4ONhgnY2GeKluwMwqA==
X-Gm-Gg: ATEYQzzcYcT3Pt8q/8H7E/k/P5FM/Cu6u0qQOEcYzo0RzF2JjRKNRWw9V/AXKwalxmq
	zojKf4/jJ2zDUXBw8Dq50wBlnqNKIViwQtxdRdkDBqyEzPR7lEwwTHWOZtGiVmMLmXWjfdjcyLv
	1g3VSHiEck+FcMLwlts9Niue9+zMFqeVU87r7RRGxHMxu8VG0e4HJeiuwGvs/elLhmcloDmpDOJ
	KF/RUA5foKrU+xWFf153mnG0eslTnaA73K4/VjlTlabigu56dbA+xRGKVGmjhfvox9GKQ0EMZSG
	aa+/1qq/
X-Received: by 2002:a05:6512:10c4:b0:5a1:4b12:b153 with SMTP id
 2adb3069b0e04-5a14b12b233mr739363e87.39.1773056609261; Mon, 09 Mar 2026
 04:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026022351-badness-custody-28ad@gregkh> <CAPDyKFp=9qL2XROcTXDsv106FdoFwzziFU6YpBCB85aQ5ZFZRA@mail.gmail.com>
 <2026030816-womb-recollect-bdb4@gregkh>
In-Reply-To: <2026030816-womb-recollect-bdb4@gregkh>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Mar 2026 12:42:53 +0100
X-Gm-Features: AaiRm50P9V039w1s1EVWWiP_XG-9flMJgOniW-OZbcAdNM6wlfaE8K1RUHiqsaQ
Message-ID: <CAPDyKFptyTf6HJbUf0eRXiutP=hLTjoxmRQb2ut1w4Z7RbvkSQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: moxart: fix potential use-after-free on remove path.
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Mar 2026 at 19:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 04, 2026 at 05:25:25PM +0100, Ulf Hansson wrote:
> > On Mon, 23 Feb 2026 at 14:48, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > Just like in commit bd2db32e7c3e ("moxart: fix potential use-after-free
> > > on remove path"), we should wait until after we are finished writing to
> > > the mmc host device before removing it, otherwise it could have been
> > > already freed.
> >
> > mmc_remove_host() doesn't actually free the host, but it reverses what
> > mmc_add_host() did during probe.
> >
> > Since the moxart driver uses devm_mmc_alloc_host() the last reference
> > to the host will be dropped after ->remove() completes, leading to
> > mmc_free_host() to be called for it.
>
> Then how did commit bd2db32e7c3e ("moxart: fix potential use-after-free
> on remove path") do anything?  It really wasn't needed either?  And so
> the CVE related to it should be rejected?

No, commit bd2db32e7c3e is perfectly okay and solves the intended problem.

Before the moxart driver was converted to use devm_mmc_alloc_host() in
commit 973aa22b9f1a, it used mmc_alloc_host() during probe.

Calling mmc_free_host() is needed in these cases, but it should
typically be the final thing a ->remove() callback does, in order to
clean up correctly and prevent use-after-free bugs.

[...]

Kind regards
Uffe

Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A0C3290BA
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773059405; cv=pass; b=UMBUzx/mda1JOkQ64rg8PqbWWoE4S5SyBkEtrVwB737ctySia4S8VWO/9PVSRjOSLEEo4cHFEXaQpd03BaTDhMwy9W1nX+cILJxpoXBHhYcl2JtMl+f6XEg8kMCyqOhJpUhKrWdpmUXAIPFMrUPPrLJPCMon+u8A20luj4cgfu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773059405; c=relaxed/simple;
	bh=pYgGBDvghWjxALWUrLZVchUlZam6w7kcUym7ErxR/Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6X0MPfgbrT/6PTxyXs3FCZM2Ww2EI5UQuQRnxbeRC72r/estelOXHzz4Vj2DHIWi07VZb1x1kGC8Z5UUMJaLZnZCbJxztC1qBQr5AtHyX/0I+AZZn83ctfcgjBhCh5ijUuOi60sjBclWLOYFzmA2eCIW8A+DnPbnRZpNSx/qx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CZ+RYdj2; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CZ+RYdj2"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a1273de95aso5989012e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 05:30:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773059402; cv=none;
        d=google.com; s=arc-20240605;
        b=ec6LnAcPPMN8lJJ9eeDtkljlVrwe08J+YiN9667QI3MdBek8a4Wv5mgXcEdnPBJHQ9
         UEQHfDAYMxgsWoOoRCJ2Cy0DqVp8hEMd5MKRrXkXd/VfRnnt7nopziHocU3qc+0JAC+b
         D6n6f/naSkSGCVEhLIKn+zC6qKQLZ2+Nv+vRz+5PxOo41nVRL94Al5rLiJYHFc+5RVXR
         5+8HAzO92BSVpw0d8FSfWTubGI06fwDm6nXfFNkTk03jFd3dl2t2qNFqP8ApI7b0aCvp
         dflswpy06k0TFRmz3rYcUir4VRU5XMdSuKc6JtM4lgmtZMy/tt77QmXjpjBOYTqZPY3j
         5oHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fhTTawkXi7VuzC64v4RaQE5yZEr4dy4eyiIQ/ZOc1Hw=;
        fh=dmy6u3WrvBWEcPkBRsBgpFWRLw/uWrPePJRBnVXnh7s=;
        b=YnFVx0fO/VNcDt9Kl7wtqdPIz5sYNdgj7KPXpQt9lke44tEzfdW62/uyguFIHiYQbZ
         Od4vyHS5qfxZcaf8cg/Lyu0NoCk8Bf74xY9WUWkho5/HktYh4+w7qic6EmMSzIHRGt+r
         smKcHj7OiYSz/I1jiQVSceSBD04PDe8Xyo7YbgROiR5aydldywTzb0dkIIKI3FDfFfRh
         b0mAQt6U1Ty86P2qs+N0Zcm5JNclONJe2XFh5SUpWCtXGstVUYJgcn0EVwaiY2FWQMji
         fGRNJkYBOp/5py2gkWRKdWbRyR7L6A9vnLHoZ09vJmCOyB9liVE/9b1L4fTK2+jORwJo
         LDXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773059402; x=1773664202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fhTTawkXi7VuzC64v4RaQE5yZEr4dy4eyiIQ/ZOc1Hw=;
        b=CZ+RYdj2H0GGlB2AddSNVkijkbZA+9+7jxvj/AcfMBjD19qlUPhed5lQnYemA+Wq3m
         Y2cV6T0MvAlpmArcaFY0sURa/QjWW7w8T8XiUF+V0TOTrPKrljB9EZc/vRy9t0tIuKun
         B0OOOJfcU1Pf4Ci5m2JsX1LLqsoZ4aIvGACSFowYC7ZAZHU1e1ai7nVGyKySfj18inQu
         7GkF9h20joFnCjLwM0kmZKHzk4cM2X7n62epk07bQo/Kmhnh9Yfe8JmzwSQ9cLDfWIWB
         vY2YgxmPzW7FVFq9HmzzkUsC7FFnGzoATiuHIlF/gqm0yt+tgq+jNInaLJkWBiAOPnK/
         O3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773059402; x=1773664202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhTTawkXi7VuzC64v4RaQE5yZEr4dy4eyiIQ/ZOc1Hw=;
        b=CcN0Iqc5OlgvIoD6AqVaHpwiPJl7ApEGIv99No6cdwlA+N5z7jq4eqt+QwD5/VkmyT
         xGlv6rgaCODAn+5y5GuXZ/gKFW8n9IyAHVRBLz3zt4yBUz2Fd1dKFjfymAlGxSkIzKfL
         0klbj4SwN/lQL+b7KdgMRRv7S7E3H0VqRUMGe3rpZBsWnVc5vLOLQ64ZOXE29SPoSozT
         2UCXM5Rthxt0oZkNwL2uZkzFTWaHKi+HKnxz04tSNmObELpiMuoG4+FBeS21UiU3UXGU
         6148debDSHO9MOQGzLGzNbyOk1D7LfT+UjYfQHDpRyVA+UJf5SQzRQgPpPhCDE5rLdEB
         jXfA==
X-Gm-Message-State: AOJu0YzIkGPHFSZL1PFYwh06j8/zcOuQYuMwlaw5DIJEeqtpoyrKYhix
	PyZRLNt9aGFsGpfBlCcqWpEYG27za1p8VoCswUrfepDMdnTrvGzrAMPvyDM/PRc9MUL9zFcqKH2
	ovzHZ7Oty5zIhmr4hk6r4DC9oaCFq1utFOIs02kADQA==
X-Gm-Gg: ATEYQzx7nBWKMBs+pcm/BAOVh9l14eK+cWs3SIpYnlkn3fcZaxswQDDUIn6FhQgUFu5
	2prj8mE+uNE0MLJtqjtYoB81/BRrQ3j1YTw2hGbZr4y/oZCOEmEfjKUBq3ifzrLb1sk4NrSTkJs
	klm0LKmR0njkpmAhSfAbvaiytiug7nOIssg6Wy5noC3eobqsol3ygXsTCz0fCt94rQK561mVT+/
	VGsNckP61kKp0sRwwIoFjVgLw0bxOts9vAamdh/pEElaRMQ5P4n9QbbYlgse3X56HxlmB3W8rsd
	4JkqxwO8
X-Received: by 2002:a05:6512:6092:b0:59e:62b2:3fce with SMTP id
 2adb3069b0e04-5a13cce398fmr4220474e87.25.1773059400531; Mon, 09 Mar 2026
 05:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026022351-badness-custody-28ad@gregkh> <CAPDyKFp=9qL2XROcTXDsv106FdoFwzziFU6YpBCB85aQ5ZFZRA@mail.gmail.com>
 <2026030816-womb-recollect-bdb4@gregkh> <CAPDyKFptyTf6HJbUf0eRXiutP=hLTjoxmRQb2ut1w4Z7RbvkSQ@mail.gmail.com>
 <2026030953-overrate-saddlebag-9cef@gregkh>
In-Reply-To: <2026030953-overrate-saddlebag-9cef@gregkh>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Mar 2026 13:29:24 +0100
X-Gm-Features: AaiRm52ATX_M9KxLPRvCDgLlIwONvevvqbHlXDqyJ-buCElgR-u1vadIkZfJQoU
Message-ID: <CAPDyKFpbKzMn_1nnN3pkx803a88SBphJ9mWz7x2+88E=FWiT4Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: moxart: fix potential use-after-free on remove path.
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Mar 2026 at 13:24, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Mar 09, 2026 at 12:42:53PM +0100, Ulf Hansson wrote:
> > On Sun, 8 Mar 2026 at 19:03, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Mar 04, 2026 at 05:25:25PM +0100, Ulf Hansson wrote:
> > > > On Mon, 23 Feb 2026 at 14:48, Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > Just like in commit bd2db32e7c3e ("moxart: fix potential use-after-free
> > > > > on remove path"), we should wait until after we are finished writing to
> > > > > the mmc host device before removing it, otherwise it could have been
> > > > > already freed.
> > > >
> > > > mmc_remove_host() doesn't actually free the host, but it reverses what
> > > > mmc_add_host() did during probe.
> > > >
> > > > Since the moxart driver uses devm_mmc_alloc_host() the last reference
> > > > to the host will be dropped after ->remove() completes, leading to
> > > > mmc_free_host() to be called for it.
> > >
> > > Then how did commit bd2db32e7c3e ("moxart: fix potential use-after-free
> > > on remove path") do anything?  It really wasn't needed either?  And so
> > > the CVE related to it should be rejected?
> >
> > No, commit bd2db32e7c3e is perfectly okay and solves the intended problem.
> >
> > Before the moxart driver was converted to use devm_mmc_alloc_host() in
> > commit 973aa22b9f1a, it used mmc_alloc_host() during probe.
>
> Ah, that makes more sense, thanks, I was confused.
>
> > Calling mmc_free_host() is needed in these cases, but it should
> > typically be the final thing a ->remove() callback does, in order to
> > clean up correctly and prevent use-after-free bugs.
>
> I moved the call to be the "final thing" in these patches, so they are
> ok?

No, mmc_free_host() should be in the end (unless the devm* variant is
used in probe), while mmc_remove_host() should be in the beginning.

Kind regards
Uffe

Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C451BC46
	for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856032; cv=pass; b=iIhXQ3M2eO3Kb0ofWcsYnxTB677VN0DeRCOmTpbwcftY7GcU4+KNC0fNHjjeL9KBdEp4UxtkCGe3MheHGYNvrkSd27tbx8UcRYVWCQe06/pHqm09nwAVtXoBMHZNeUrDYNKZtv1wLLgsgP2WJUVPSJMEUUJ8KbxZ8jor0ADnf/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856032; c=relaxed/simple;
	bh=LlIochDNkBSTg+8NAW8Qf3EC9A/pn1xYqt0R0kwbDwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPj8LR99QcOvaSlXzoTBC7G2EDvDUmb0cThqBA/fOYXvOKlA4DC19ik1roMhpt0+vNp2aRAMENHKpciaajKDBhTgSxHKf2klLtY2JimUVocf0nPBWWQFeLhsXmwCmCU25v97YOGzvzXd6KQTFlGtRm3kgg46WKh0lnCQtxhjhdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lwtc2hJN; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lwtc2hJN"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59e0d5c446cso4992786e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 06:13:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771856029; cv=none;
        d=google.com; s=arc-20240605;
        b=VMLHvk3/iVYGzr32BxkRZKIgshSlU0FHcbG+gY8wAnpAUVhRJz1aQeyaw6Egg6Lal1
         sHKyqlq51iimmGKPiEGcQOyOvgXGfIKfXPhaWy2+HsV0jMzvhWbL+0v3BQFYNx+Tb76p
         uSyCBUyiuYViu2BblS+W+WFYV0gKL6SVZZqyxVjfq5nt47QNg1zdFgwcsT/jnrC5RTZP
         Xlw8lhgExKZOvq0gHce6kcuzae5CJekaufEnrytnQ9ZOfyQgroTHZLsP8i9SpRQ3WICX
         He9HAQ26h7qhAjqX/seAImIn6fJn0+iNdcyHewPXsnlsBTETwsZG1ph9T4IwGpc1IGfo
         L1tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Z365Ew48+czBlM95FTfIaD+tm+sBdKd6v75QU+ouN7w=;
        fh=R7WbjQ81d50QjU0ztl8RJxeBnWj/cAWPjWkEQwQ32Dk=;
        b=LYrFmwEjpVNY/WffgF9zu3KDGEycSrxop+CBLLwQrxbIjROEtgWmxlCMVzjd3wmeRp
         qB9pyKISmgDqwKvOwRsbFOVXJfTXldETFSvW7j+sjsqiq+deI2egPv/RzYpMq2sAGxGc
         kPcUaQlTzWxAzUIdq2CVscQTVXvQVvaboIqH2uKdBqzw8at1o+UhYgnOr9rL6DrsjFF8
         tPEOmfl12pcDAQwrSnaD+kMFVbjjZGehi/huo1Tl8zV4xl2y+Y7wr9k7jM8enr9BVeoh
         ntswRb1RgXajTe9ygavd2qKP/qLk/LQo+/zNwpOMgL/N5Dh5o6PaFVraNIru/aqEGNbr
         FLCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771856029; x=1772460829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z365Ew48+czBlM95FTfIaD+tm+sBdKd6v75QU+ouN7w=;
        b=lwtc2hJNgHnTg/RsyjcuXZRB/M2dYL3n8MX89e2qHWmPM4FpyIKbYXhMygQFoP360+
         z02IzTX2L96mLZwnV65HRkC0HfiOZwxukHfJda8XtdkTXm0AC7mqItBJpok2ofYilniQ
         85SItBPqXBZDVVE5swjtDyMvgQlSB/5cdzk1vYp7BASEHjKYEfJ2yNwLQYKz9P0FZB15
         520StCZg8S3J05O9YGHeHtrMpKlFXFj25/rTmv3YWW2oYO/Y/AKxVCEEipseiiFwcdHG
         LPopjcaxwVvh3w0cs96putGnp4nOg08IHj0Ezuuu3IdoIIfm/J8PXSKbuOAMn0Fkq72z
         1JKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771856029; x=1772460829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z365Ew48+czBlM95FTfIaD+tm+sBdKd6v75QU+ouN7w=;
        b=bDqzbe7ucFbhxrJflFv0TXKe8uE67Ooh5p9/ZJKKZkaH70Tj3reBit7u3KMXDkERQ0
         JpbNVi4NVkMEAieMZu2oWJ4RtpBophKrz7FFNm72dKhU5z8pBSggwP5oMjnaam/sNj11
         hMCWESsxIKujaQD2hKyvrMsi9FC7qR7atEm4EdHVQp0/RDXlPoKFhEG02fmHdCsNj9ok
         Hh1/hee5Mhj3O02OhU3uZevnuiLXqhOFMRrLKh16Rp+zbTIxw9XMrtggS8LR+A3YTDDq
         3+O5O1hijkpH1XAr/oA13ZO5h0LszvlhSRbtfHWAdpUohBj/fxejfjQJW2xYkztn87hl
         ZpLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnaQolWBLaUddztNAa+zjmVT7Tv2y8qYrAONVXzYqQ+4jWF2LUrUhJkWN0wbS+XNWCW6Ej/Il3qHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytuukGGdBXQKYoKmTelMDP1VxVbOEMyVlf5XoHwQzQfSz05UFw
	BJ/rZreFqT6cD5GqobW9RCZtszuxebkxReBZ/m8ncqYcLFDFFJ+GfxJu7gdE/zDrN/9H4xEFJ/6
	wUI8IU2KKHe86lVzV4/I8PKr21iTGkcb1ZlZRi5rDPg==
X-Gm-Gg: AZuq6aI3afPbLcG2Q6ecz+tJwYAu7E905PYUsX9jb0+/jjZLlycuioaqCjL6yqmxT8k
	rW7vSlpkgt0ukgtu3OnPNp2O7jvD0vvDK55rq/ZuHcf+M9/rKLLTUdiL5Znl1B+kw+qCnHUr0H0
	M1jzx2wVK5q170xi7tRElC3IyPhIEd7FvOndlCDM6l7dwWpvR0GKlC9b8wyCJfs/IP5dgHy2QUS
	kGLT/Q2L0HOvRWm/BkXqQ9sonjXdUet61iWRT+ol8dRQmPhIOoa8tMJZt5G67uFgXwql3aA2HEQ
	75/XDJow
X-Received: by 2002:a2e:a984:0:b0:385:d6b2:f4cc with SMTP id
 38308e7fff4ca-389a5dbcf47mr27888201fa.19.1771856029038; Mon, 23 Feb 2026
 06:13:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222-mmc-pic32-v1-0-110382af02b0@redhat.com>
In-Reply-To: <20260222-mmc-pic32-v1-0-110382af02b0@redhat.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Feb 2026 15:13:13 +0100
X-Gm-Features: AaiRm5063zwSFsLmpAu8KKQoob-Xrkb5LYHlwF_yOCR9Qri5bmnQY0n5wA-UtxU
Message-ID: <CAPDyKFpVxiEwXtxnrjpLsrwCXSo=LfPMRJd2APAberOg=ME-jg@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: sdhci-pic32: allow driver to be compiled with COMPILE_TEST
To: Brian Masney <bmasney@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Feb 2026 at 00:39, Brian Masney <bmasney@redhat.com> wrote:
>
> While migrating a pic32 clk driver off of a legacy API, I mistakenly
> broke one of the drivers, and the issue could have been caught with a
> simple compile test. Now that the dependent patches have been merged
> into Linus's tree via the MIPS tree, we can now enable COMPILE_TEST
> for pic32 driver in this subsystem.
>
> While changes are being made to this driver, let's also fix a single
> outstanding checkpatch.pl error with this driver.
>
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
> Brian Masney (2):
>       mmc: sdhci-pic32: add SPDX license identifier
>       mmc: sdhci-pic32: allow driver to be compiled with COMPILE_TEST
>
>  drivers/mmc/host/Kconfig       | 2 +-
>  drivers/mmc/host/sdhci-pic32.c | 5 +----
>  2 files changed, 2 insertions(+), 5 deletions(-)
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260222-mmc-pic32-137b3eae8e66
>
> Best regards,
> --
> Brian Masney <bmasney@redhat.com>

The series applied for next, thanks!

Kind regards
Uffe

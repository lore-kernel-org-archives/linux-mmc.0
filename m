Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD6E33438F
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231637; cv=none; b=s4fjWRLCBlFw2YaomMHHzqnq35zC+81BUTnMNGA6bY2JE2gTx9IACfr1jCulKUmAr/eRVaY6ceXXsbYb/4WKxunRXVn1cEibGlNCEnm5yzBusbA0eRbKRBptR5ztl9J4sUVjZlBtOpkUE7Rv8X/5KxRXqWru4w0aMDmD7+3vBQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231637; c=relaxed/simple;
	bh=EPTvx8s1xjF3tQm2xAcjvTwi2857pglx45RNhQja5kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRsys3gOwC8BAW/ddhNBeLZBHwKB/vVs+6TPwScLtUMHyqXlQRWdwUYjHBl+M+0Lc53xFKlL01MgiIGPrxj6BWUTi3YLwnj0/mJw91/RGdyuikgCepHy4SoBBKilun8Bl7hCEv+vM4i9/bg4BDAGdK+bKW9fEiyGlhlwMKdGreY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+uWeNry; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+uWeNry"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so1022421a91.1
        for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 08:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761231635; x=1761836435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPTvx8s1xjF3tQm2xAcjvTwi2857pglx45RNhQja5kU=;
        b=C+uWeNryTmjDhfNqoaZqlV5UhvfttDlkcPH6mDmNeKO/uzlVfqti8xAqmDzu3UoJPv
         RS8xw2AdUxaywAm7fXehZuvE8l02o3wufFTujWb7tI6TTrFjKX39JKYYkI6kMXW3nqWQ
         deoatgxPdvnNyMEgdTZZR8N914WzYfMpcacC7nnVQx5AHTof09Baj7dhHsJHQoIgeL9x
         ROK0DPDJJ4FkIldinnbe3loSstW12CD7oZjy1Fza3muJqWnGHSubsFlXPa2qkRd+V9dn
         3iLayCd2wzqQeH2ggiB2QxnhM6MgqFqb8Vi7MA3OLJkMvvajtJk1oTgWWW+HFe9dhnbL
         hFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231635; x=1761836435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPTvx8s1xjF3tQm2xAcjvTwi2857pglx45RNhQja5kU=;
        b=KLvtc4gjCGCV8zPb+7oETx0qIBzMO8DJYTOcyfRNDqBCiu2aMJljyoW4iun7bw7BTR
         597H0hncctCgp++zF/snX+YRbYnD0bi5WpVhVY1ycQLRr6Scp0fybKxXz2IRXaC7HWJU
         R/75VggdPPTkFBAl2Ycwx1D4s4Wy0l/mgGfz9njZtVh9JT2gJOGnWKOQnlgiGes8AzoB
         B5+omgG6Pqjh1cv+6n+ZZoIOX860QW8KhLzM+72hNCkGqTVABNMfxq4mnJrGhnZbBXH8
         5B/9nVjEXhjH3KQ+AM+PFVpQ3lfQp1QkQSyVPufyd50EG+dRffGL0VjgaNvFE9wAfd4Q
         /Jxw==
X-Forwarded-Encrypted: i=1; AJvYcCUHH5RyYcvBUi5YS1uoTTHIdrTN14cI97vu/Y0qgtT/2IWSB/J0kO5ieoBVR+5uXMIo/Ub+hfzDsXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynF3EIw1tjoN1MhZ60hzsHZioDgOL/cjze9cEWhEIRpai19W6K
	YABCK59V1riSke7RdrnDYQAOf62sVGdZWEoLy5t3FFokWCRGOvfN08yEK0mnbMD3
X-Gm-Gg: ASbGnctfiOPNtqJyGC0uQFICbeD0iNSc11Wc9BevgJPLutF1PtkAM2I7KE4CYMgOwrv
	aD9nrqSkhdI9Nw6CG5EDuQMJN8fcbxEDST0JuwbCEq3LEBo0JhlpLJJZhn4cFKPPbzHKDAlPzYR
	SvUJJBWlEffANxnlc7N1s6oEMCiAsTAzdA25lBw2etNNyaNxgDKD4rMQDn726NANu8pa40V4AsW
	TJ2/l0Wu1i3Ha6ozfmFYK6+Dekmt9/zUUiDXIql9RV+/0KxzepkOpaHDI9V8PWatleWdd+2+tf0
	kuwAb/WPvbZYi0YyCrky4XktDVLhnBeTHMAve69T8950+NriPnMYcm1RquZU1THmvoYbXcdphjP
	YjWcpYCPkTjNfFV7wTfscIGdlTda7FrD7+JJaAAbemsyklxQfZl/OCWZuJkfDerITTeugc0ymaU
	73cSq7KIbpBpEPRCBhCRPByPTcirup
X-Google-Smtp-Source: AGHT+IHn4PZEKXYm1+7LvVn4UMOqVz90PtQ2psqXknB6QS8j2BPnoDTfZDXsRQz5Bj7sIQFcKZg0BQ==
X-Received: by 2002:a17:90b:2491:b0:33e:2d0f:4792 with SMTP id 98e67ed59e1d1-33e2d0f58cdmr5814814a91.28.1761231634351;
        Thu, 23 Oct 2025 08:00:34 -0700 (PDT)
Received: from rakuram-MSI.. ([2409:40f4:2040:16ed:f15f:ed0a:f0b7:34d2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff3704f6sm4373510a91.2.2025.10.23.08.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 08:00:34 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: u.kleine-koenig@baylibre.com
Cc: chenhuacai@kernel.org,
	dan.carpenter@linaro.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	lkp@intel.com,
	rakuram.e96@gmail.com,
	skhan@linuxfoundation.org,
	ulf.hansson@linaro.org,
	zhoubinbin@loongson.cn
Subject: Re: [PATCH v2] mmc: pxamci: Simplify pxamci_probe() error handling using devm APIs
Date: Thu, 23 Oct 2025 20:30:23 +0530
Message-ID: <20251023150025.167523-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: itxfh366j3yhshvp5abji6xussdk2fc7zrtvc3zzk27y5ouwpb@fvvxnpg3keu
References: <itxfh366j3yhshvp5abji6xussdk2fc7zrtvc3zzk27y5ouwpb@fvvxnpg3keus>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 23 Oct 2025 at 18:28, Uwe Kleine-König <u.kleine-koenig@baylibre.com> wrote:
>
> Hello Rakuram,
>
> On Thu, Oct 23, 2025 at 05:28:17PM +0530, Rakuram Eswaran wrote:
> > On Tue, 21 Oct 2025 at 14:01, Uwe Kleine-König <u.kleine-koenig@baylibre.com> wrote:
> > > Yes, I suggest to make restructuring .remote a separate patch. (But
> > > removing dma_release_channel belongs into the patch that introduces devm
> > > to allocate the dma channels.)
> >
> > I believe ".remote" is a typo and you're referring to the _remove() function.
> > Removing if(mmc) condition check from pxamci_remove() can be handled in a
> > separate cleanup patch, while removing redundant dma_release_channel()
> > will be included in v3.
> >
> > Is my above understanding correct?
>
> ack. remote vs. remove is one of my most-committed typos :-D
>

Understood, thank you for confirming.

I've just sent the v3 patch. You can find it here:
https://lore.kernel.org/linux-mmc/20251023145432.164696-1-rakuram.e96@gmail.com/T/#u

Best Regards,
Rakuram


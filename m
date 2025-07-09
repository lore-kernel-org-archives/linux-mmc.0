Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E6D298CD2;
	Wed,  9 Jul 2025 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059710; cv=none; b=KUFRtO+dL8Bo2YEA3dMUCgZLvIB3Dt0oE+7UFCymGUFOboos5AZ9nPtVw+iD15toiFjXilKgU2DK14y+Kz7z3503vBTJTbdesLzsbDqzqF6tFT38dX+G0vhEd0n6aBPChhtdfIFIDkyCbezSMubdIGyfHDrHr2qHL1IgSN4FiCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059710; c=relaxed/simple;
	bh=a8DMwP9O0e1/Ks1uaUvyjR9ZwVN8Yzfcz4uS0h2kHS0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyAjXx0YO1/46B0U2HSYX29VXZilrL7RmvdM3sjj+5GIxXy0ioedioQCZtKIUGzA9Pr3+BveUxC0UetmV3iKgBhi/eqVfZxfHArhtSD3ZIjCG1L5YMBmlCFsz/4fmudgOSSNWUU3bf9zIa0yQyUPlSni3uzX5RErq3cycnDqagg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XC6lacEi; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XC6lacEi"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553e5df44f8so4754343e87.3;
        Wed, 09 Jul 2025 04:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752059706; x=1752664506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtDkh085fWauG5Pjux6pyT6Ge2pLuEpYKgqPvj2je3A=;
        b=XC6lacEiZahMApqR04NRXQJdaadZaOGIhlrVeX17+4ZPyBFx5PN7uERLS+RCGDHCFZ
         glHpm4fst90HrtRDeNuJF+d8TvlqOgv17eOpbu1+Psl60LZ6gH2KuHUYYxVFOhq78855
         Gn5w8pBuriXmVA2sES2a8UE4fjsf93GSd72SKzW2IkDxD0QV2VeorM/ng5MSPMa8kXJ4
         XgyCYmkMdL0DDz+L9eIh1lLQbLP59OaDf43eKA1vEsxJqBHDJq6dzZ93Hhy+o9aXE3jJ
         G9pTcMBWeLHaIxJ4ogan2AFHA2XCNTf/uYZWEl7I5jmN3PaFO2fB7jmVxgAJKqPNBg1m
         hWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752059706; x=1752664506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtDkh085fWauG5Pjux6pyT6Ge2pLuEpYKgqPvj2je3A=;
        b=EgequrUMYlG2UV0voCjlRAEmfFgOigYPiid3KD0WI1YJpaggyML48dbWjqmv5wcDGG
         9mtUInXSb5eJx1wb9ERlMhzAdrljpeEzshV1YM8ID672Zg4EQjIBn5fOT8MHn3XpVVjt
         96sLdf9w7G4ed1QVsHwMTidDDeKgX7y0u5OsCerGHTb9Y85DkN6N6h1NRWHXHuacDl3w
         HNVIuweusAd2lC9kqiB3BJoidB3Tip3jFTY/idvenYJtK/cLW1xxJHGfcVH9KqdtM0rc
         ZNdZ1qo0rgf8zD/XA/dhv5y7EpgQSh5MNJxhZLCTt/6ehZFJdkdskRcUt3iGGz8XmPlP
         fF2g==
X-Forwarded-Encrypted: i=1; AJvYcCWGx9BZRngll9gtsCvqi4bYZeUt7dYOOQSJXvATjNQUUUhKTTqGD5dPAUP1pm+BbLQTxgs2VDzhANFcFRLsI4k=@vger.kernel.org, AJvYcCXPhsIzPUPimf4ovUCyLAKFk9jBEs7EzxGUSBM0Lz5iZxb/fl8LjO+FHD6WyNZAalbxjMkiNEsBmyyNyA8=@vger.kernel.org, AJvYcCXc7JdKJyoUGkLKL8VmkMOH/gqbnmQWmg6WNwJVbH1QH+vJG62Na9zpascvLayGkJvcnmRXm1Xw+v2B@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1O45bpNISX0mmfugbnmfZW8JdsTH6fjKxwlW4MUoySMgrgmQg
	a2l/Rb/uPEajNoIFxOSfLbjwU1dVHisk/tFPdv5Q3j/uHAiFsInWIr/0
X-Gm-Gg: ASbGnctRRTYfFIqbcCwzxie2PGpJcK0sR3UkARBSHQqT19YNK5S3L3co74Ht/IvCDCQ
	XamQYl03LynIjB1Ri0Rxr1/rDW5lWSqCY6DqbGdk0TDtJ96YcTFyYNq1HjkvjKHjuulpCFvdxbl
	3DX1yIlWrtlFjKHIPvBF9TEbvJztcf6DV6GxCGtr4ygDN5n0hJ1EQbUay6BwbtAQ21nrRH8RMDp
	XvcsarzELE4oMFewdCy0dopubD3k0I1niJcjju5aTBec6k1+2tkwXp6KzL8BWWqu6Jkt+ciAJLF
	gALPhaervVBaUlP1nyBLrFlv0IVeEW9l/RuIBiN+mPvFFgzRU/As9+q0CtdD10YmpQPFCOc0j6l
	2MAqEOmywyUW/R56L
X-Google-Smtp-Source: AGHT+IFDmGVILm6QvnmVsRRbSuqd61cRV/xvyf97TV77g1DEUM9cN9dTUuaPpm2HVcKr88VWPuNZAw==
X-Received: by 2002:a05:6512:b8e:b0:553:2dce:3aab with SMTP id 2adb3069b0e04-558fa909857mr689591e87.40.1752059705735;
        Wed, 09 Jul 2025 04:15:05 -0700 (PDT)
Received: from pc636 (host-90-233-203-201.mobileonline.telia.com. [90.233.203.201])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383bb3fdsm1948129e87.44.2025.07.09.04.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 04:15:04 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 9 Jul 2025 13:15:03 +0200
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>, rust-for-linux@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add mm folks as reviewers to rust alloc
Message-ID: <aG5PN42vPXbeNyn1@pc636>
References: <20250708183747.104286-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708183747.104286-1-lorenzo.stoakes@oracle.com>

On Tue, Jul 08, 2025 at 07:37:47PM +0100, Lorenzo Stoakes wrote:
> The alloc implementation is a thin wrapper over slab/vmalloc, so to help
> out on the mm side of things and to be cc'd on changes, add some mm people
> as reviewers.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 71599ab6bd56..54dd937160ac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21751,6 +21751,10 @@ K:	\b(?i:rust)\b
>  
>  RUST [ALLOC]
>  M:	Danilo Krummrich <dakr@kernel.org>
> +R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> +R:	Vlastimil Babka <vbabka@suse.cz>
> +R:	Liam R. Howlett <Liam.Howlett@oracle.com>
> +R:	Uladzislau Rezki <urezki@gmail.com>
>  L:	rust-for-linux@vger.kernel.org
>  S:	Maintained
>  T:	git https://github.com/Rust-for-Linux/linux.git alloc-next
> -- 
> 2.50.0
> 
Acked-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9ACB66F
	for <linux-mmc@vger.kernel.org>; Tue, 13 Feb 2024 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842785; cv=none; b=SS35TJssPrWXBZXd8k5OT+IIk8IFBgJ0gEOFvj2mR7t5DG+Hb5/Z1ckwsNiT3oRLYRABWdFBLxvCQMEKG+ubl0G5IKtPZ2bpCgrFA3CyFy+t/nZPJR0LaVu2/bdXG/7OwZLVewyByLZD7cjsXjnD90E1e7QnfKn2YPsVnZL7XjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842785; c=relaxed/simple;
	bh=qLwyUT1WDaJkmtc1ktAdhzGZdAoIw9Yxyb+2sQS97nQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hx2iJptlHC4cBg5pUomO3lLR9XWHJO0pmpbUEALfPLdTEQA9Y0BuBRcc7707KBOE/1DA8UoN9zvFUug9xdMfJaX9VrE20cFWSH/i8TDiOEAl/NTgfupeHcjUnIFhrhQWSleiXMsnww7z7uFau0/ZgUdhZrenaD2Vwt0SBIjAY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TS99mw1i; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TS99mw1i"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6077a1d441eso14127347b3.1
        for <linux-mmc@vger.kernel.org>; Tue, 13 Feb 2024 08:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707842781; x=1708447581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eoJh2tr4FRlgildwrsRsaxdcgRdL5qVvqZCjhMVH4Ko=;
        b=TS99mw1ivCob+GNJBKb8uCCh9sAf8omFMpCDfJTy7W2v8sWUeRJP0vz9g0ikOBGMM7
         GNuV/P0bTEca7+OlGy5nXSXig++5DVaK1olldsBDOcEohAHims2iFOvR8PBF2ooleiR8
         CKYWYZKW80AdEH+047+ZpD5/IoAGtzVIVhVaHEHetbhs2E2sz3+S51aAuqON1+vDs+Ry
         0A+kvl1bzZzAXUspvpm4aBXiPxa5p2CXC41Swnr0UpX87MTl5ovsjfeMSJ27tLUP8EF4
         J0B8XZhp3rKZ4dezyxjEaisFc3kR9vpO9g3aM+LFoqo1zM23MVqEh0Q4Ug+qKAHdW8qV
         4V2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707842781; x=1708447581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eoJh2tr4FRlgildwrsRsaxdcgRdL5qVvqZCjhMVH4Ko=;
        b=DPMrC+uTXZZQJ5XfGXoOTPhsqdXepOzLCG+e9dyE1CBk1FchqmHPTThJGkvaCp3CP0
         AzC2WOkPABwvS+G+/V/rVzz3a4YNgJ/zbGjYA9Exg6Vstb7VSKvnmWiHhDgQMODjoQ47
         KDg96IUaIZy5ZnThtl9kPgkL1bwCtcpctFahECj4j2LCagLDrC5fRhodOHLAv+EXBBXa
         ToPq/bfkFiin/eznb0P9gGbaaDztZNaOR282Mo8xPph0vzOYGh1fOj2508nzL25QF3Ua
         KwJ7zlc1dLFNgCVD4nMrjLyTx0xu92X5Ey0gtEF3XxqYJ4AWZxyVz6OOMQ/ZInfCFY6L
         lSQA==
X-Forwarded-Encrypted: i=1; AJvYcCXmstTYpeBOkrQVX67fi72e2htwPJ/0pMWh/vUmM3wWkT7cXz1K6rrFtQw6KBprjEmUOKtv9/tNu1aFepb+wvzHFjQeRbJxJ/2J
X-Gm-Message-State: AOJu0Ywsk0mhWxDFoeMJSd/n2bRcv25t7QQ0RUtxNQpho8fFSX37F2mz
	xcmB22hiZZRgYD1sPGJYe1GvWNfxRU86yVFywoV71EkjhZkra8es+nhMvfVUEOpTrjNt5cyMvPl
	U39yF04mdGwzqj9tcKjaKqvFRbF4f8boWmED2wQ==
X-Google-Smtp-Source: AGHT+IFRerUNGbTgBU3wwf+oG/ehW5Ekk/0QwzhAC8Xq9yczIGeKWYHJlcAKuGRj+5ja1rh2Bcscw93PtgyqvkaSKmI=
X-Received: by 2002:a0d:d382:0:b0:604:7b9e:f622 with SMTP id
 v124-20020a0dd382000000b006047b9ef622mr6848335ywd.30.1707842781524; Tue, 13
 Feb 2024 08:46:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209160934.3866475-1-quic_jhugo@quicinc.com>
In-Reply-To: <20240209160934.3866475-1-quic_jhugo@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 13 Feb 2024 17:45:45 +0100
Message-ID: <CAPDyKFqjnsF44YRgr2vvdfWi6P9FxPuNkgfYFKbPWqECgY_eeA@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Update bouncing @codeaurora addresses
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: adrian.hunter@intel.com, ritesh.list@gmail.com, quic_asutoshd@quicinc.com, 
	quic_bjorande@quicinc.com, linux-mmc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 17:10, Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:
>
> The @codeaurora email domain's servers have been decommissioned for a
> long while now, and any emails addressed there will bounce.
>
> Asutosh has an entry in .mailmap pointing to a new address, but
> MAINTAINERS still lists an old @codeaurora address.  Update MAINTAINERS
> to match .mailmap for anyone reading the file directly.
>
> Ritesh appears to have changed jobs, but looks to be still active in the
> community.  Update Ritesh's address to the one used in recient community
> postings.  Also Ritesh has indicated their entry should be changed from
> Maintainer (M:) to Reviewer (R:) so make that update while we are making
> changes to the entry.
>
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> v2: Change Ritesh to R: per Ritesh's suggestion
>
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4be2fd097f26..56b3311e51de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7832,8 +7832,8 @@ F:        drivers/media/usb/em28xx/
>
>  EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER
>  M:     Adrian Hunter <adrian.hunter@intel.com>
> -M:     Ritesh Harjani <riteshh@codeaurora.org>
> -M:     Asutosh Das <asutoshd@codeaurora.org>
> +M:     Asutosh Das <quic_asutoshd@quicinc.com>
> +R:     Ritesh Harjani <ritesh.list@gmail.com>
>  L:     linux-mmc@vger.kernel.org
>  S:     Supported
>  F:     drivers/mmc/host/cqhci*
> --
> 2.34.1
>
>

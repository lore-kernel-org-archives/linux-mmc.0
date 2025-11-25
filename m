Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B89225779
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764086785; cv=none; b=AJbD6jeZRXYcIiW8A0Z++2Fjdsc4I8iW9nOwxdSSzznDxn9/SHpkulj0Yq8ZeHgMBVLAiUSwSCdPAA2xooSQQ2x0wPXZ47ybwqsHu96v8Eb8FFUL+ee9rzbDM+jatV0J5geI5LbqiPf/KVTflxt6Jk+7Z/PA9QSRb5k+hychkAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764086785; c=relaxed/simple;
	bh=Mgxg05/WbgpnmDu8gC9V/611e7uF6txV7D50JvIbaH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2Abl0+D56VVtQHg/CmI2NyBPSNCWlEiuTo+U8gb2Nh56Xjz7fIL2r3ZpnIPFHEZretHqylMil7VZ+RFdHdjgjpSgtMG+BO7onhhpvdDiKOmz9ze9rqlP96/CvloDsPHG+YLAYruTmpkcL7J5E32qb77SbxynV8pFhOwqG5S/CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lJ6vLcmQ; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lJ6vLcmQ"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-640d0895d7cso7484320d50.1
        for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 08:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764086782; x=1764691582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mgxg05/WbgpnmDu8gC9V/611e7uF6txV7D50JvIbaH0=;
        b=lJ6vLcmQBtM7OnRreCmVHQMWMc2E3h3jVzJISm/59O1vgyDh/tTRpJKZRnnvR4QSHA
         icjDnADPwyX7P1ysTk7VYtW8tw1EsJyvDHCRLlF2UequchU95+F75tY9TgzoSWJF845V
         pSrjBbcbEajbp0XNMS7Y8j1ST2k7+6q/1FgKgPOqbPpHiZHd7eDRzwHNX54lNOTXQ+FR
         T3xamuOqZTc1X/jq//2tUlOa89IMp65SkZVVHUgFZZBKnVtTirY5FPjkfzb4ZZ4SQnUN
         gdvjsGXB27YKf+6+FFIspKsZoK9sa2gLLfG5sZZgE+DftQsXk00Tj0ZesOkZcpizZr48
         IHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764086782; x=1764691582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mgxg05/WbgpnmDu8gC9V/611e7uF6txV7D50JvIbaH0=;
        b=gtnkFWqllkiIo6hZdfU25fwUMs3Ow2I36ju3ASkmRNl+vzXYoAhEmlDutHiPPLOs++
         MPiSC18FJWmVM2691H5SW5xm/FMHem0Z8//7wcOuD2eGi+oJg+crsT9ipTOXOcpUyEAW
         3bWAxhyocemzB0cP2PjoFSYsrVPODRHbC9CTrFxsYXc5sTio/gZxIqW7+EFtKI4PKDJk
         yDLs3W7AUsWNWNU/SvtwgxAbE9SvzKSdC39U06P+hv0A1Bcox1VYI8EhALUfZvocewEw
         aeL4I0xlx52wA98h8OjSLs4iNsqnyq/jwUHMO9SW4vO686DDxfNhcQ8GsbVpfaGJybcj
         +c4w==
X-Forwarded-Encrypted: i=1; AJvYcCWpRzmAJXikMed/bjbJUnrskmesjBPGC2An3EmB/E0IPk1K9nA0y0F6XQFRPQ3gOoAJd5BtUXkryLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUxTSQ2kqZ0bEeszpjQd0mepMuWzWTx0CvZVoPT1txPvn1hue9
	fVacEuBxNE8Rj/M8qpuYw4pCaOCpzulgl2TtxRZaLpwCuTOSoAmQHt8pv82kZUghh81mHOcNI8A
	SBUkBrOOZD7rff0aKM25OpWixLMx5vQ+7ytSWN4O672Si7xFz8LLM
X-Gm-Gg: ASbGncuqopQRvE8iXWcx044BdZigDtPP+UFakk5Qsr7OAXUs2oRaYz0ubCCST2pbz2h
	CXOCPXjiapQ5MTHnBFEbHpxbtwqpSc/K04x9wpw9rIuWlp/MG60T1xev33NhR0Xnlmqye5zxm8/
	/1WIPCi/k7DZoBdl6xN3tX3iXrr2qkjIjHkmAza1YLSkeqwqnaP2u606C5ulOLSXQeKftlSt7QN
	HWfG5rJg2Z1eCf/I/LR+6v5N8IidJ4Wq13uYPkuhwp2ZuSQU1Qsui8fFw==
X-Google-Smtp-Source: AGHT+IG/fwrJeS4b8lAlZrSfNrGokzEhmOyZ2TLJnBVpriaPDwx4wc8ej39ZJN0/PFlzT86GGeccI3dEtLG93kPWmH0=
X-Received: by 2002:a05:690e:1443:b0:63f:a4ca:dc21 with SMTP id
 956f58d0204a3-642f8e2e343mr12949162d50.19.1764086782341; Tue, 25 Nov 2025
 08:06:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1762933460-204066-1-git-send-email-shawn.lin@rock-chips.com>
 <1762933460-204066-2-git-send-email-shawn.lin@rock-chips.com>
 <7b05327d-fc76-471e-9148-3dfc0cd17623@rock-chips.com> <CAPDyKFrx_5cnyFeLRhoia2aHK9Cxo+fp_kKhyQ526xE02_+vSA@mail.gmail.com>
In-Reply-To: <CAPDyKFrx_5cnyFeLRhoia2aHK9Cxo+fp_kKhyQ526xE02_+vSA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 25 Nov 2025 17:05:46 +0100
X-Gm-Features: AWmQ_bmxgc4FwcE0BpkQ6Q6feIrE7xCIIDMFZYvC3Ae3VEbj3M5hAGVRSkguKC8
Message-ID: <CAPDyKFoBezDP9DsCFVhS3n+Vm0rQv_Hs2g5svyD2KQ5A-rezwg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-dwcmshc: reduce CIT for better performance
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Nov 2025 at 17:02, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 25 Nov 2025 at 14:58, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> >
> > =E5=9C=A8 2025/11/12 =E6=98=9F=E6=9C=9F=E4=B8=89 15:44, Shawn Lin =E5=
=86=99=E9=81=93:
> > > CQHCI_SSC1.CIT indicates to the CQE the polling period to use for
> > > periodic SEND_QUEUE_STATUS (CMD13) polling. Some eMMCs have only one
> > > hardware queue, and CMD13 can only query one slot at a time for data
> > > transmission, which cannot be processed in parallel. Modifying the
> > > CMD13 query interval can increase the query frequency and improve
> > > random write performance.
> > >
> >
> > Ping...
> >
> > Adrain acked these two patches, so will them be candidates for 6.19
> > given the merge windows is coming soon?
>
> Looks like I simply failed to see them. Possibly because there was
> cover-letter, which makes it harder for me to follow all the different

/s/cover-letter/no cover-letter

[...]

Kind regards
Uffe

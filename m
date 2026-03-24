Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328C523EAAD
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 00:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774312061; cv=none; b=qI8LOU5iFhR81kuhDXFfNFhRaVKugSptHEzmjBI4GJRZ8w3dVoom08a6HZz/uawKfNAsDc/cRmFLysehlPgYuNm2Fyu53i+Nn3aHJ/3agk8SAj12f52JsuJeOSYCBG8d2lQerG/ZBVRS1vvmYnd524/D/64NiVRQuVO4dV3hm4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774312061; c=relaxed/simple;
	bh=BMoEvEnUl7Bh4tQdglttGrAYLXiS9NmJp2DZxhfhqEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcULchnZDHnOVRp9QARtCg/G64NKL1c3tasLApk+HWRGfrVlhdtVJ7TfdLE5iGyu6UySQDOZIgwyHKqqwqK8jIrYqXTDizx8zOO/8JU/xs6cyCGxEdRQ8Yj7HnASH018kNAmcmbVHev74IDV0+f/dGsymwZoQ8qY0fdcwCsQN0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPsdkCak; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPsdkCak"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ad9238d8fso6134705d50.3
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 17:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774312059; x=1774916859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMoEvEnUl7Bh4tQdglttGrAYLXiS9NmJp2DZxhfhqEE=;
        b=iPsdkCakELEg780yE75895ENptdblGvnj/MVDN/mqB8G3X3K/AzP4Ny+dOLyx98tDt
         y3yG5mUiTlMZnpsQVcGwkAK/p10VDVC0USZw1uG5KlDl7ootCWIoppWoBGO7w1u46CfC
         6NttU8EMN2cKLEBO5KfHIc10ZbPHFp+JU6R1HyyHaS4FX91p8VHOXymGGAlui8QHaLbF
         BIGqHOJUMDI8Sp1avDZ2OscuTpas2MVhaVdbipIAFj3JTdjtFFHlSSsnYjN3whUuLrOM
         VQCW/KKSFCLHCYQ5YocRdWOMsSIzb2KQzFE9tJfBM6F8/aTyiZRtDd0fPO7IoXpdmUYl
         kdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774312059; x=1774916859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BMoEvEnUl7Bh4tQdglttGrAYLXiS9NmJp2DZxhfhqEE=;
        b=YBmaJbtozQY9+odakFzV0P4V9nhegsvaLU6MTZAtMW8nBbWXw3+4vzMt11W8m6jAYs
         VMersK2uO49Q0BRRniFPz6kqsAOdYTMzhkgyZFeg4qnvWbMdXrP6eGW5dS+y0ZwVAYbO
         3uv66MkhcvIIXJLc/81mbs+RXOxMvEEPsJOGxGeBAs7Xw+6OoEAmJTG7qEaeocDp2Xnu
         LXbnBt8CT6mC7XxS5+U2G2JEab68Aw/Jnd2QcBpEZ87j0fYTAg+6+dSlG/2laDOiYAKW
         Dky3/aYEwgR5EyCT8QKT6yPisgABfhGXHBTbv03QRWgs/7AHXP4zJyefkbsXHHTrxoI4
         ebqw==
X-Forwarded-Encrypted: i=1; AJvYcCWf7zEcJqq4qsCBVR2anP1lQ6L+Df2gx7dudlf7M/oDWNB6+b8A3tMoBVgCbcqcpdX0SNXpikfnmcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJbkMgazjS6GODcuNGrAg79TLmAwkT6VGSzxX3UhTE6pW9gFB4
	Botktu3a0a7+sK7uGqx5p3v/etF2qK3UFEfpfyLh3JhpHgF+Sx24G7bH
X-Gm-Gg: ATEYQzyatzGnt2N/khq6QRbBnZOCFmymqTbuqBsIv6tnaHl88dJsR9ki5PnLrmqulhc
	cqS1MxltrmGZw+hZA8JKtV0Gx7rCoTZH6ffxsG6XxRD4DlnmNYlLdHmzbm4wrggK1gMABq8Z/02
	DD0CQZtJIJDy95KMWMaLVan/OkBCFuXsk1Fqv7BD39W+Mf4X1Noqszy6n58F3tvhigg0qDZrxcs
	RyUhFpn1w6TAYZUZ06YZWqhhOGwV6iOF5jPmYIxfv+rSti4SfcXk9noYddoq7X1IKm5J1qcLh2a
	5rv/yTzUXBk21NUfN8OPArYdChcTN/pGPsYIPKL+WH+gY2xzhmpraAAfGAYl8ugZnvj8PHNmeZ/
	WmdfwHz3QR2HewLtRxFnH6Rgo3G9EMgDMCqbAl1Cg3aNYxLtgmq+DxsMAODhqWiv9PpOyQXazjC
	5bni8svRKKNn49TMaDGz+UeaC0RsdMtZQWf4yXOrEbZEdcL48QYg==
X-Received: by 2002:a53:bb08:0:b0:64c:9c10:c09 with SMTP id 956f58d0204a3-64eaa7b37demr10726757d50.51.1774312059187;
        Mon, 23 Mar 2026 17:27:39 -0700 (PDT)
Received: from Starblazer007.localdomain ([12.206.154.114])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64eabd6a005sm6935816d50.5.2026.03.23.17.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 17:27:38 -0700 (PDT)
From: Nelson Johnson <nzjfr547@gmail.com>
To: andriy.shevchenko@intel.com
Cc: hansg@kernel.org,
	adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH 0/3] mmc: Lenovo N22 Braswell SD slot fixes
Date: Mon, 23 Mar 2026 19:27:35 -0500
Message-ID: <20260324002735.21092-1-nzjfr547@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <acEScW4vpBvVgkXF@ashevche-desk.local>
References: <acEScW4vpBvVgkXF@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Mar 23, 2026 at 12:14:09PM +0200, Andy Shevchenko wrote:
> A side note: Your email lost the In-reply-to and possibly other
> headers, so it looks like a new email thread, however by subject
> it seems as a reply into the previous discussion. Check if you
> have nothing wrong with your email setup.

Apologies for the broken threading. It looks like my last reply
did not preserve the expected threading headers on-list. As a
first-time submitter I was not aware of the distinction between
on-list and off-list replies. I will reply to list-archived
messages going forward and double-check the generated headers
before sending.

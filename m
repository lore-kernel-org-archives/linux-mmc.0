Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982E02080C7
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041899; cv=none; b=oPlRxi48INv6jFD7kzI7Jllj93i6hdRW+CYS7aqm6pB/7Wi6daVKS8My+sq1wawbpQt4IQE92jLeAwiRraTygkxGImTN2bGxG5NA0TPpCWzNTu8ucZFY+6zWwW8iKQ8+lMNjqa4MUUWjRs6J24ZqL1lAhPSpzUqYnAWUdves/1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041899; c=relaxed/simple;
	bh=EsyAkb+E/Vx2Pf5QNAmePM6Wum91PuEAZobvU/Trbwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nf9lgJsiP3OW5FOLJmyx4V+SGI9YK51Aa28i2DJ/hDg/lAtJqmtMgeMbny8rr+kknshYO9GmjHqFz08RNltLq749KErV3N1P2jJnZWWLx9s+N9GBiFPLlkw4mf0/FiDumN9w6hdUEhw/aXzhsOUYgG8gHqkVM+PJgYlWm207Yn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kcS6x+aT; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kcS6x+aT"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ff2adbba3fso41943967b3.2
        for <linux-mmc@vger.kernel.org>; Mon, 07 Apr 2025 09:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744041896; x=1744646696; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PRtsR6xVM6ZICvsMHRTNEQJgU7qZB7aRP4KnHCrPc+w=;
        b=kcS6x+aTkHj/AVvOgI2CTNrRZAoECZtH0huKHm5sGQYXCgKKbHgKJUu7xUdHmJsPXw
         kqnncFElGFcyq7YSWVENNY3waCz7ZLqPwziALeSa5vNgSVfN+D3N3fqS0Ym4ITVgZQcn
         I4MyRy2MiE06UqJFk7hSQ/Z8V1mxx6wJHRN/8/Gny0rETsUQ5ju9Xb04FNZOQe0Lcu5E
         hGHeGQHDWhh5ayhTIEfSvWnwYscPFOTi4d7VofxvjxKieaEYQcxxoxsi1umVqaVw0oWk
         VLDmLgF6ocM3s5Jxy+25dvnD53ZvYBxSOAMkD8JJrEPDQEiDyJ/RtoGQ22A2MdBSxL4W
         69AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744041896; x=1744646696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRtsR6xVM6ZICvsMHRTNEQJgU7qZB7aRP4KnHCrPc+w=;
        b=HkN7tdHMS38067JgBpLT1H/euJJvL18troc2AdXSvCmw/ysIpfYfePa7psdrPMLzDW
         Z7kJtESMzQ44R7fXvc9MuhHbRehFyQP375ivrzuvmHXW6MlqTKZcLNLU+BDMWrvjC1CT
         0D5MhKpjQdL+GH9WLq9Nh/lum12O3OxWmj/0GVRfiK2nKT6L7CrPpHNb+B3ZejF2muVU
         QpkluwnSCE964ISv45Zde1qwv0OWasd1+llUla6X5x0WKNtM+XsG0FdiEP5VICqOjgKW
         xGOnIHEgV0BCNqhO3+DoMF+ItPAG1Q7CGZe8zdcsxBROtvtYyZTF7nDpquC9XR/7ayA5
         uH+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/VkRIrZjD0U2+9bwgkydQOLnr10ZHKDmK+MvjeZySIreSoFvkGc6/jpufsGDvUHyO3ysGWnPH8Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMk6KL81Z/AsvJ5rnPxdL31YhHf5Q0bbBDThgzXfOcYXI+0lSO
	1fQ6KquiN9im3HFpp4zGEPNA6Vpym9la2MuAMhtDv03r3/0ibDO2Ud6RNmg9p4qE1Exkl24TLWG
	NA5CdQZtac46lGOdZZfPys/m0IIANOkrbyhKK8g==
X-Gm-Gg: ASbGncsjIK3F89k9iqY3jhj4IpqiFxU12QNzN3rhLUosibqFTODhxw4eMhr4vQKfnBP
	xiBtGhPPvE4JehsAqOy5aY30ti/CELdAqHo22Vh2t0hBW6zbjpYsCgJPc0jGMc7MzCHEAUO/0So
	zJd4WRHvk90U63NndjQaZvCPzNQWQ=
X-Google-Smtp-Source: AGHT+IEgtyhHcw5Jpgfae/63h0KNZCvI+qxXPeZypusFjvmWFk+cO1XtdFw/5d+hW1tCksobHOcrVkCj/XZ7Ug4xyF0=
X-Received: by 2002:a05:690c:3686:b0:703:ac44:d37e with SMTP id
 00721157ae682-703f42fc111mr168754697b3.37.1744041896281; Mon, 07 Apr 2025
 09:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320211922.1135669-1-robh@kernel.org>
In-Reply-To: <20250320211922.1135669-1-robh@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 7 Apr 2025 18:04:19 +0200
X-Gm-Features: ATxdqUH-tbXCaf4ePanPkHh6DiK3ftNM3BoL1J4Avf3yLjwSBSY2qumPHOTnSI8
Message-ID: <CAPDyKFpzxK3AaEPsWjkgmPCjCO6u8NeWdZiStWst_Uzdda9MBA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: Remove redundant sdhci.txt
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 22:19, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> The properties in sdhci.txt are documented in sdhci-common.yaml, too.
> Remove the txt binding.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci.txt | 13 -------------
>  1 file changed, 13 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci.txt b/Documentation/devicetree/bindings/mmc/sdhci.txt
> deleted file mode 100644
> index 0e9923a64024..000000000000
> --- a/Documentation/devicetree/bindings/mmc/sdhci.txt
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -The properties specific for SD host controllers. For properties shared by MMC
> -host controllers refer to the mmc[1] bindings.
> -
> -  [1] Documentation/devicetree/bindings/mmc/mmc.txt
> -
> -Optional properties:
> -- sdhci-caps-mask: The sdhci capabilities register is incorrect. This 64bit
> -  property corresponds to the bits in the sdhci capability register. If the bit
> -  is on in the mask then the bit is incorrect in the register and should be
> -  turned off, before applying sdhci-caps.
> -- sdhci-caps: The sdhci capabilities register is incorrect. This 64bit
> -  property corresponds to the bits in the sdhci capability register. If the
> -  bit is on in the property then the bit should be turned on.
> --
> 2.47.2
>

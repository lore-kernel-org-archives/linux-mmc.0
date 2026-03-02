Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E93EDAB3
	for <linux-mmc@vger.kernel.org>; Mon,  2 Mar 2026 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458027; cv=pass; b=WiQRg6Z69zC3L+3MpC3ykmKQ45ebLM49+TCu0Oyh4g6hDu+HGWoiVNZX6OP6C7wgspeeS4ZV4G9cMFJ65+6n4qc8jOl15HtCTkgk24RRt3Y7Ar5kYeyTG0lv7h8KXoMZLvOIc81u3QwJYOHlG461eSb9EchdgTf/T6DNW+otJ6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458027; c=relaxed/simple;
	bh=D56P8UfBC6muFJ2DiCU/NOHe2w+/5CdDZNfPlxqtIl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pE+brCZJGYXkT3R+/vB2oR9LGzEI0UVbku2lQ/WbMVN1ky3TTSRz4I1m2v2NO9Rz1cXm5iMKX+Gb2DFpx4AiKQIE44o5dyWgJBLfjGgpa+OLAJjk2j+5Wjp4yN/CqFmnjc8BaCD2vLq9bPKJB7YK/0XZrg5PAE2hzHai+dHiimA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPa3HaKR; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPa3HaKR"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c7103601c8cso1982915a12.2
        for <linux-mmc@vger.kernel.org>; Mon, 02 Mar 2026 05:26:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772458017; cv=none;
        d=google.com; s=arc-20240605;
        b=VF0w4VbhxylT5qkw1iEXQQMW5wx1exBT98rYANvdOq0oawVQ9Ef9pKQElkfhhx8O15
         +hnhDPePdx94HR3IK8eP7uVu5wSV4Fvvrdm8Z5KM/hiQv32p+ez/YBJuCriD+vuB/Byl
         R3+HMsLmunBJyld4T5SLyQWLaaes9Pvp86VOv5G+Qx2PuYwNUQqeVC5sUWS1b4tTanDJ
         g8EPZWBWGpdcHk7CbqpLmhJ/8Pq7/Io038mTj6g0oc08w3S2XxaoGMIQZzlQHdACmH7V
         Ax4Y2ykn/gtFr4tdjDKsD8qFR0e6bN9iXk9xWvIPVCPmyek3LowSdTi2ExGVqU/6kwie
         UhgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=D56P8UfBC6muFJ2DiCU/NOHe2w+/5CdDZNfPlxqtIl4=;
        fh=b40G5L4PYN9lS0nMMu+wkvYK0qwB/Os5ws8sH9Bi6vk=;
        b=D4q/VYkYpB8KuhI7fE6UrFDlekmrRPJ/8gyEJRUT7k5iqfbJs9TOVu9tv5GC+6g8Py
         2zDlxaL/87jVWiSP78NzbrqtW6XXuVEpuR9pq6+ViVjnEi+d9w5cjZvHnED+BCML2ZgH
         j/ay5bLW92ImDhHM64oCO8v/9QbLb/D+v19TK+N1ig+9ZxFTBLCFvGPoEur70THs1ZlP
         odR7Ry1HWkUVwSMatonx4WC+j/C3uPEZvUyvubBuN23jzXaK9azvBoLsCNALsYKgfYGI
         QEtmz/aJTvFwi3Kx7LcTKoUgLEfVilmqBtvVPjtTG0dXKfz9s2tMyHY2xYE4UBr8Ziya
         zZnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772458017; x=1773062817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D56P8UfBC6muFJ2DiCU/NOHe2w+/5CdDZNfPlxqtIl4=;
        b=fPa3HaKRvPqfBbAWHgZ/8rFn9R+S9cZ4L+H5Xe+Cqp6trk0oHbeZjNOqFup+Bf68Z/
         V3kTCqJzZu+6T0N0SJAJoAUUyrk8rOHSy5+fRFN90IQaSGIUG5YvGKHD3nriQ7iBa76P
         nOkzvvuTzhVo8DBpPg3jHGSK4EV9O+mtULGHddSwUAkI64qrcG5FtnB1k53J/z+rnzVf
         L3+sqcbW4+qPyVrsH+IPWAh7Kep02ajOod9/tixIsjVJUz73z8Art090jByA+5/Zo9dN
         L/x/uMiBgzhWK4xHVbd8S3z0b6fOzODBU2wNkOAZOT2V3v0vOgAyzlChWXhf0hMKHUSe
         LEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772458017; x=1773062817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D56P8UfBC6muFJ2DiCU/NOHe2w+/5CdDZNfPlxqtIl4=;
        b=jCL7SkZQHuT/ciSL7BDcWlwh0baBjbNezLkPno0FpPsAn8DkP9QhIJu8wjZ6G04t7e
         D6LBcgLiEE8LWvfNHAJDIvFjhywCqVH+Ydb7o3yn0J49U2NzxzlVGv7XvVQnfnSugs59
         Wrn0OZSgLJQx8ha6dDKsKW/AhxmjBs0VYu8tY5zqwPjCtD4IyC0g8Z9GZOO3aMliVc7T
         2WwbjXykyxynZeqDnNEPNoCDddcYcIcoGQusJotjJ+YM3zyWkr0aWCNqprJTW1N7yIYc
         vI9Xky2TuIEG/y4ep7eWcw2/F5FBH5z9wxK/Q+SMGsMrSAW5sYcCOAHPCYCqJYGJSUIN
         5Trw==
X-Forwarded-Encrypted: i=1; AJvYcCXlzyXNsra3NhdN3bPZRfe6iAOXNFfQeNMjI4EggwVv5tOziMON1H+p+qbtfmHLLIdgktQPSbhbC1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu4F917pZZ+1QtgpKlZaVk1jtbpeVw0ktcLgQxVZmrn/SqIXW+
	7R9no0wvFbtkz64JYzHaQaA/7ujbs+EkCYBYGbje8Htc42nyllZ4U9dcpHLCqYuA7fwqn58gwh0
	IeoScVigRuQrBorDeQ5K73qqu++Vt8t4=
X-Gm-Gg: ATEYQzzpL1nnEqlmoDL2vs20MYa3N+/3y7FL/WYQfDIDJ70LpI1Qq3YCBTGpfOJYGj6
	iK1VGXwzQ0PrBqRGVjDD7q2D8u7elCjZIF7hh30rk8GE5pfDyGwRNv3tr+5e6S5PxBEqBg4O3y5
	Uhh6PFS9y7HK1yHZvebqI5tTbVDpwWdBjuIk1BF/E2wDdUlLtCdKFeboyAxFZUXZneql/PVNkDd
	u6OtIVDX8F294LvizUY37xVU9FJMOvlLLa2ikrsY6dttYdoH//2cirVKTEifpVC/71ve4JYB5aK
	gIJ2W3OA3CFLnL4FRsE=
X-Received: by 2002:a17:90b:574f:b0:356:7b41:d355 with SMTP id
 98e67ed59e1d1-35965c382f1mr8489218a91.1.1772458017387; Mon, 02 Mar 2026
 05:26:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301-bst-v1-1-ddbc22ec3ed9@gmail.com> <6e0e650b-d349-4a9a-9dbd-8244fb050b9e@intel.com>
In-Reply-To: <6e0e650b-d349-4a9a-9dbd-8244fb050b9e@intel.com>
From: Felix Gu <ustc.gu@gmail.com>
Date: Mon, 2 Mar 2026 21:26:45 +0800
X-Gm-Features: AaiRm53wTBdB7vaC1WD5csl0WHPtUXSPNTJOwfTvcFo3DJQfO2VVg7CWZIHSlUY
Message-ID: <CAN4SLj32y-4BcaAvDhi1VO3ZyrFjezxYfqAn8_DQ2Q1gtzHziA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-bst: Fix memory leak in sdhci_bst_alloc_bounce_buffer()
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ge Gordon <gordon.ge@bst.ai>, 
	BST Linux Kernel Upstream Group <bst-upstream@bstai.top>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Albert Yang <yangzh0906@thundersoft.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Please use the same expression for the device as the rest of the
> function i.e. change "mmc_dev(host->mmc)" to "mmc_dev(mmc)"
>
Hi Adrian,
I will update it in V2.

Best regards,
Felix

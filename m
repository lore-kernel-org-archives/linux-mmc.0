Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281DC38839D
	for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 11:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773400881; cv=pass; b=Yd3XUuZ7utx4XEH7WszF6FBXwYNjXam4NgAp/BwVJ4LBaJXlDE18v6VFK/NKJxQ+h7tX3Q04+oDyY+t7C+IGTUtR5kan9vBCOOh+1ghRD0D0/JUsjJ4NusQLJ9bOZmo/lFhJJz852dq4nFLWvXsROCWxjuRsZ4q7jgG5GxxzX7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773400881; c=relaxed/simple;
	bh=7fVc/jZfynFeoSYgaf7HxtjcfzW1V4HoQrTDitcvLZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nu5Ubt44ROlsYXrkK9iEgw7LVVnI+R6s8RODLX0PZbeiNLpaAvCI6yaFICyUbnCWjiViIr++UEs1LuCo9NXAcc30Eo6h9m0XoXoJiiXlIUrJtShMPSYSp1fqjHzGMWBgUxUx2ckOLEjoQGjtt+NLvyplIHaizwTIg4LVvk7mNAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnb0krby; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnb0krby"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5094e1d17d3so15763231cf.3
        for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 04:21:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773400879; cv=none;
        d=google.com; s=arc-20240605;
        b=H1hzDLeutmdzqgvzxgaOjSyD+lGUjRfWyDYMfC8dl+wDBRmQ1xnGcV2sxYeqC5kGdd
         irAV/qn1f1byRVa6MaGba9k3y2mPwYZR8Q9UKR2SYy6f6q9VApO0sUDZ5rUNcmB71Uvj
         BZr5HZcvKfitOSOhqFUDdZdJon5dl0Ya+Jp9iSsrJqsvhoC58MICHj5HuRzH3KjV8p35
         76yVGpQLBSOqFLYTBAhsHDijG0R8ddu1asu6uGlKaSrvj5M80PsK7SfTeKHEtFz0/lkX
         l8OMtDr8IMSSX53aokh44cSSKcrTzg8ECl1UeO19mdd9gQtxw6FoeX04PBldCLbaWGwx
         6yPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7fVc/jZfynFeoSYgaf7HxtjcfzW1V4HoQrTDitcvLZw=;
        fh=V8iMs9W3XY5QPiq+DgInxjBK6l5RCP12Cc94/Fd7sAs=;
        b=ZmMLy6Tdnr0yEsDKwciEJCFhelorlp7TMmyJ9OLissuTPaUkTOS8mMQG9F+ejoIkYZ
         amfGP5l225jQRu0Dpf92UbF18+UATRP86qXvkjwY7ZNvA0p5B7aKo7la6U1d6fi3AfSC
         qvAtqHQ9lObyTdwUCS8Ykx4l9lxu0bohri5WssWZX9ihfaowL1ASHY9NPET9QAUYWrrM
         UitHobCdngsbe2BEr0iMm2KOJSl1q0jBLXzlY0Kkoda0FSrAHB2Y0ZLd2hwf6bmO+wVa
         6jT9CdDQWZGF9YiwWvLY4qc2aAMq+RdydzFj/M17oawU5vttjUBZCMS+Slft6q8x+e8Z
         c+XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773400879; x=1774005679; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7fVc/jZfynFeoSYgaf7HxtjcfzW1V4HoQrTDitcvLZw=;
        b=fnb0krbyj+kL0ZCYrcQfOM5r4ofVPCKfKMOqYcTm/zcyNUL7fMJmXDb2MObRDJp0Ng
         NeNikEQwKR4DBCkO/kO6jq1KykOmdpL6wT0m8rvgyPZk2u37ztI34q3qLxX0N6yIbgjq
         tqneDGx5HS0vSd3JHP/9CruLaXMMeuMqsxBCDzPQnPjGNcJrTkztVs8/BYx6//+cxuSV
         zDpUQK3MjNstADRu5QnJbjehr6nAlI81MS66TLJHmVWCPhY4UiwJEUKT++KPwLj8uTe5
         mg1Z8DwbZlAyPuy3u1lb9Qii8RTahr4XxXuQlv0+G0py+B8PbbbnEx6xgvQ2pGpvaJKU
         YCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773400879; x=1774005679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fVc/jZfynFeoSYgaf7HxtjcfzW1V4HoQrTDitcvLZw=;
        b=XXYNfLYdnZ38KHdRHgD9T+IZsV7ZAtTXXqCyYUzqEHDzQj5OtBi/qaajfbJH10JGbk
         S9bq+NwTzh42JHPT74+9sjYUQHArc3oJUXdF1RLDl0CgAAXpjnlZFq1MSk1YYGdiKhBH
         2hebrvNJ05LcpKiR/ovrowk/nXG/ENqQCLT+cWgrYerAjMTCmX1PgAEyW7nocAanP+jL
         3LbFjiH/TnYq5fSMJgTFERXlcaW85w6nZUdIOfTD2BgOZW370sbMn8TXWnP+xvCHlKNv
         5wWWpZzw66KSSdck4JJeo9lM6o4Qehq0Ww7YV3Z8ZWtMLtdN4xaAm5U4tbWkf2QEWC2/
         Avvw==
X-Forwarded-Encrypted: i=1; AJvYcCUmU7JQ+SkJdw9+JsN1roamKSCy5mkMYV+aXo1umw+4FsYdL6QtnkFjQS8HARkMcec+nouA2Ql0m6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM2CaLiN9oGKV7itEMZ3IDZe4dvK1oidD46+wgGf89p/Qlnbm6
	rcUmKG1qOTPoZyg6LvN3D/YL7iEUkr4v7tm37RXB2DZaxWrmlm1+vcWYlnWhs+vZkarUXeI6RYB
	6pcB8g0EQ2YMiX1JNNNACMXJ91rB6VLE=
X-Gm-Gg: ATEYQzymC47nYwXTlT+L00DHHSbE77vbOeHxzZa9alBr6cv8ukD08zPLoAPigVazDEA
	iDulnTK/xZLerfvirA784GlNdIhrnhp7ROt4m3oJ8G5qkGG0iCRqbILrhP11leRA5l85V6Wu1bA
	tW2rfQJJgKd4tXyyZHmmvfAw9w/wYhY8x439aQsVN+ElH9mRCsDkpn/cd3HyQ6YOjki7wpI3nW5
	2SilTlPNHnMEfva30z2uzr/obRSBFNc3THOJNjx1WpU5GOApD7cZxzOCOeFAY0Xq+XdYTKee3LN
	C4bu8A==
X-Received: by 2002:ac8:5946:0:b0:509:2222:4202 with SMTP id
 d75a77b69052e-50957e65448mr38456401cf.71.1773400879027; Fri, 13 Mar 2026
 04:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com> <20260309-orangepi-sd-card-uhs-v2-7-5bb2b574df5d@gmail.com>
In-Reply-To: <20260309-orangepi-sd-card-uhs-v2-7-5bb2b574df5d@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 13 Mar 2026 16:50:59 +0530
X-Gm-Features: AaiRm51wBTKcyCiwjUblmLGy3GXdm8W7RXj8vtcE2IrwfuzlmNKUiXiuwUzU7RE
Message-ID: <CANAwSgTkyyPYExj8fwhtG1mEmKkKWqQf3ZwaJrsvj90sMf1kJQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] riscv: dts: spacemit: k1-orangepi-rv2: add SD card
 support with UHS modes
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
	Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Iker,

On Mon, 9 Mar 2026 at 17:11, Iker Pedrosa <ikerpedrosam@gmail.com> wrote:
>
> Add complete SD card controller support with UHS high-speed modes.
>
> - Enable sdhci0 controller with 4-bit bus width
> - Configure card detect GPIO with inversion
> - Connect vmmc-supply to buck4 for 3.3V card power
> - Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
> - Add dual pinctrl states for voltage-dependent pin configuration
> - Support UHS-I SDR25, SDR50, and SDR104 modes
>
> This enables full SD card functionality including high-speed UHS modes
> for improved performance.
>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>

Can you add the same node for k1-bananapi-f3.dts in the next version?

Thanks
-Anand

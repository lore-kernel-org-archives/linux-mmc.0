Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3123B19D071
	for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 01:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768874078; cv=none; b=EaJvbbu9gX+TxiuOjlTOWDnGkQ6ONrLBqzX2WW+rAdBBOLXAfBk71/psJWpuaSW5r9Sks/8Cdjump1p6nfpFjtXwyF2zk9rpGF9xgX09azJmvQc7ViJRz1dP8OVMletW84AFf9wiXIUCbukVMuSnCcoxV5hfhUFMTx2lBiJlLTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768874078; c=relaxed/simple;
	bh=0CpFIUoNQxzCsEqiOC9Tot7+YhNBK8bbLQBjNBE+Whg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZC4MtUTpMv4DjyFzp0lIdVU+SNaU9aEcUD56kLc7wkoEea0POsFN4ZpAATtAebVNqAdzTo8uxu4QMdx9tsx2cgC7TfCtBmZ9sj44Kv6XP26WIe7VCHazpwSEhnH3NTQp7TCqkQWlEms8XExfLaOcbY2/tnzTrWSb/EuwW76KE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDR9AA/S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDR9AA/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0551C16AAE
	for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 01:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768874077;
	bh=0CpFIUoNQxzCsEqiOC9Tot7+YhNBK8bbLQBjNBE+Whg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HDR9AA/SAsTWh7Cp/LvXHK4oavlJ+NI2i/YstM0RgVZoOFydeI+PJ1iSiQJbqUCuA
	 rQRqzo6JCQNXjFwdYgV+2+hfNNdbUmkdASFtL+eAOdBJvpHRayguyP1fpEz+bm8w36
	 RTNsgNJ/8ruW64htmDg5zRZ2QimUk0D/LLQ/0rMFT6MfdakRBK/YCp6mkCB0nAbsTl
	 nOgBIQ9z1a82Z6cwHfmXIVHUt4bY041IyfHpxUrVpOKZ+WZTuyJ0QKJeM90iU/f1rw
	 UomvZ/XFtUyjgf+1xYzHhgKzx1fvtjWZWF4fdt2lzAwuzw7TMCvxWqMn/I1OLjlvgm
	 MdViyXwDbXDGA==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6505d141d02so8387550a12.3
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 17:54:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7Z+jaQjwp0AFRc4G0Wt3C5UKUEsZBVwpzB13VGEpGmC00s0ndKPK8uqafTY9pNaF62sGOy/s/i4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrygupjSkryyUYjOUB7kKjSfZF751TG1x1PVGu5KEhd70Kq71P
	BFvW9DlTiIm4okcMrcIkjmoMDC9BFcAK0wkkA3cdnbE51p7pQ/eusN5MUsuWbYfwD+CoEYUjr+T
	5S0DHchhfyOua42qekraosluBHVOMTA==
X-Received: by 2002:a05:6402:2348:b0:64b:7307:9b00 with SMTP id
 4fb4d7f45d1cf-657ff2a6953mr281430a12.5.1768874076364; Mon, 19 Jan 2026
 17:54:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org> <87tswhswsp.fsf@bootlin.com>
In-Reply-To: <87tswhswsp.fsf@bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 19 Jan 2026 19:54:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ7_yKRTCOrxcq0QDy_MRMCRMQqhH=TKiBs=nubqNN9HA@mail.gmail.com>
X-Gm-Features: AZwV_QjPR6v0rtDsZSDoolTLomCXXNQMjCA8Bg08oauq1HlF9vmo2OSFeFzVJj0
Message-ID: <CAL_JsqJ7_yKRTCOrxcq0QDy_MRMCRMQqhH=TKiBs=nubqNN9HA@mail.gmail.com>
Subject: Re: [PATCH 00/10] dt-bindings: mtd: Partition binding fixes and restructuring
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Brian Norris <computersforpeace@gmail.com>, Kamal Dasu <kdasu.kdev@gmail.com>, 
	William Zhang <william.zhang@broadcom.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Simon Glass <sjg@chromium.org>, Linus Walleij <linusw@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Marcus Folkesson <marcus.folkesson@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>, 
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 4:48=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hello Rob,
>
> On 08/01/2026 at 11:53:09 -06, "Rob Herring (Arm)" <robh@kernel.org> wrot=
e:
>
> > The partition bindings fail to restrict undefined properties. This is
> > primarily on fixed-partitions which can be nested and partition nodes
> > without a compatible string. This series fixes those issues and then
> > several problems exposed by restricting undefined properties. As part o=
f
> > this, the schema structure is reworked to follow more conventional
> > structure of applying schemas by compatible and a schema only checks 1
> > level of nodes (unless possible child nodes are fixed).
>
> The series does not apply cleanly, I tried mtd/next and then
> v6.19-rc1. Can you please rebase it and fix the conflicts (at least 2
> patches fail, and then I stopped)?

I rebased on mtd/next and sent v2. I only saw one conflict though, and
that was with seama.yaml. That's going to conflict with Linus' tree,
but the resolution is take the deleted file.

Rob

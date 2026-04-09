Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10C034C81E;
	Thu,  9 Apr 2026 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719170; cv=none; b=kN00Bwueb6SoVP+5d3cNQSUZf8F/RIeZ3P2LAyOHiFaubTkxktWv6bXaBJZjlK7jYKUPeJl/vTOC/esV8LF+4a8q9XdW90DePcKBhqhe3wka8KpO3Ymp0mGmmCnqqUOpPuBMJatJLAWfAFuuATytAO0TX6tfCV46kj5zW4nw4/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719170; c=relaxed/simple;
	bh=EFGUv70ITPjDkPlE6l39I6DKElpPeVcUYVP/gjkeVxY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=qyb0/ZrL1VVfHZWYRxw3tp1E+Nj92XX4LcD4JFHm79+K8bxxg1iAH7yVqsICfSVOFpDIeS+Bk8TWwAzrhujQyfWfVkzGT+n8pUNCnkSn0bxdEDUXYRUGeYmm3d4zEf8O6XQQoQh24V0q7YfbZGL9AoQyA2Oe/Cjo2ZI/E7LBX6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=linux.spacemit.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
X-QQ-mid: zesmtpgz7t1775719054tbf8afb00
X-QQ-Originating-IP: 6bD4fn6zlzoRNsyvWerVgSjVIcx6UZ4MsVvp6bysC1Q=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 09 Apr 2026 15:17:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6790880675297523126
X-QQ-CSender: troy.mitchell@linux.spacemit.com
Sender: troy.mitchell@linux.spacemit.com
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Apr 2026 15:17:32 +0800
Message-Id: <DHOFVAYOFU7X.3J8VHC8FFYXD9@linux.dev>
Subject: Re: [PATCH v6 5/9] riscv: dts: spacemit: k1: add SD card controller
 and pinctrl support
From: "Troy Mitchell" <troy.mitchell@linux.dev>
To: "Iker Pedrosa" <ikerpedrosam@gmail.com>, "Ulf Hansson"
 <ulf.hansson@linaro.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Adrian Hunter" <adrian.hunter@intel.com>, "Paul Walmsley"
 <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou"
 <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "Yixun Lan"
 <dlan@kernel.org>
Cc: "Troy Mitchell" <troy.mitchell@linux.dev>, "Michael Opdenacker"
 <michael.opdenacker@rootcommit.com>, "Javier Martinez Canillas"
 <javierm@redhat.com>, <linux-mmc@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Anand Moon"
 <linux.amoon@gmail.com>, "Trevor Gamblin" <tgamblin@baylibre.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260407-orangepi-sd-card-uhs-v6-0-b5b8a1b2bfc8@gmail.com>
 <20260407-orangepi-sd-card-uhs-v6-5-b5b8a1b2bfc8@gmail.com>
In-Reply-To: <20260407-orangepi-sd-card-uhs-v6-5-b5b8a1b2bfc8@gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NhdiEwnVOUqEtK9rx+pHVF8kFsreCVp/RwxLRClWLSneN9acdashbOyA
	KwEvA1AH7fxFCwvYhmMogt9mXaolPQMHBNkbBzGuUq3jj8Va6/ZmcAJhjTLI1Gj8HPjU2Io
	UImhl6D11VOZkP221TQk/r4aZIsoukUftWCjMvLMzDNbwvPzsZHV9NdCsEBnOzVc5JH8VUS
	2dKoiWiC9Mf6TAxB0L5DAS0sDvjPICRD20eGCYAwQFmg+RbPfQFAgNV3FUGsFm2XSVLozCt
	J1/JfRPQGk/Hfcm+DtNj2n07Xk2gcLWJGCzO7T4qVUsGlvzVWhgde90ZUaEyngak/XLNxL8
	RwHI+3l1ek68SLPbob8j3gnkMKmBGjv0fKCRS/JWuqRFx1JkQuLtZoOGRQ59kNqm+f8dWjt
	8gpdNH2I+NYQe1syMrdgdok8BFyyt3qi8RZ/jMLGaq3Kcyz4aHzuUgyi6LVqDNSP78GmFAf
	eRXii+mF1OPFh0y12M43Z+c9zF7IZROPdKQIx7hvkwqCg50fO8hOWd8f2UgUPVZ7fdsy4gm
	RgpuUJsMG9P+W+q1owS6hQSsbTiklDIbKWSzwKnNS/QRyvdV1Vq7hACSLgn7Odz5WNac0k2
	kqU92aU01CkzBF22meT86vemIjOY2wXnv1lUkqvzZbU3p/yY5AoIMfA63zp6Fd3lMDJzcCB
	AFpbV2VCutkXoa7FlmbMGdOfnCG4QRY4ZoRXRwiJUxoWUsX2dYsstnNxG2tGiOLaXQLv115
	u9S6yCh6SODHQEqAUN5o6idaNga/JOBqEPomgDxsMi0agBicte8llCMQCFTGSzEf9mhk1i5
	szxwcyXqJRDxlrfwUMWnu8yfwMShbm838kchrQccpLaA3Z2wG1iSrWzwdEk9Xu+XN4Y4Tg4
	hzVOYfa0RcHihCc5FlNEOatVaJ23+ot9XdQWJhaISOXch/nSpW32vtCD2OVWOulawK992w0
	ZtEEqrVZTXCiLbNum+Emw59vHgjjgxcb3Km9xfMCgwceO704MBCF1rs3J4dHDVCAunEkbk7
	0dSiuzejC9VYAb9CZiTKmBuWrvmqrUIKb4LfO5oA==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

On Tue Apr 7, 2026 at 4:25 PM CST, Iker Pedrosa wrote:
> Add SD card controller infrastructure for SpacemiT K1 SoC with complete
> pinctrl support for both standard and UHS modes.
>
> - Add sdhci0 controller definition with clocks, resets and interrupts
> - Add mmc1_cfg pinctrl for 3.3V standard SD operation
> - Add mmc1_uhs_cfg pinctrl for 1.8V UHS high-speed operation
> - Configure appropriate drive strength and power-source properties
>
> This provides complete SD card infrastructure that K1-based boards can
> enable.
>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>

Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2D934845C;
	Thu, 22 Jan 2026 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769090951; cv=none; b=BDnthck769mDrgL49qCSiEcQe66bhbhNzPB0EU0QlavyDeOl8AKtyV72Z73HzpBsm1l2NQ2PxC/0GRzAEa9fsT7q+fhTWnayjn237T6Eawz1hHv1wYFdm9qGZg2F8RvEACLHDnuh1aGnm1DmZFv8PwjEe7I41rotwB8nS95DSYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769090951; c=relaxed/simple;
	bh=x3sJVvDigPgMi2h61A9uOlOFpSEZSSupoGaBjQ+gxnA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AxfxXEiV9mHhGWb5kVAbNDmEpbzRYlKedlJyMjujtrcuMFvHCi+ACl/EbXnifSXLhAQ6hH3IhbUTYwFrU5gXx6QW+SkTsLgnzjtGTh6YB1A84oQkDhKi9qVXuTGYD/XY0CPXeSyKSz4CF0V7y2Nlh/z5aRktM5YwqQ+q3yc52Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zHWCnTcV; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zHWCnTcV"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3C6F41A2A8D;
	Thu, 22 Jan 2026 14:09:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0D4FB606B6;
	Thu, 22 Jan 2026 14:09:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7C6B7119B8228;
	Thu, 22 Jan 2026 15:09:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769090946; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6+Yuq4xZjcH9MgIV1g5wa3zzuRe006S3/bFlowjAhxo=;
	b=zHWCnTcVrhE0UWdTmd0D+01VgqI1SCsW6KHIS2YK/V1Eb22U64CmQXhM/KBKhs4HZQq7jv
	l4Yi8EmYq3ABN5fZdJYU0YHqTWoPG1NR8VHU9u5OcfhFQuVMI4Y7Ww63mvFxY9kA2d8nmP
	ZFsFn1uh+PTbdMQaAPax2pm2J7yW1aauFHZwS4r7m8esdZjBHb+HACMNpVYxPVFVeeoeX5
	ALsjsEb7a0m5ZeEAJs/Kp9W/fbMjckmq0+tbetZERZn0oPLypV6vN5/6zC27MvdE5VABKx
	P/KdH/MOEu3ucDmKRjtDSynohVWOATS0E5WXDpQGgoXbE5YFOoqhJbnLjW/lrQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Brian Norris <computersforpeace@gmail.com>, 
 Kamal Dasu <kdasu.kdev@gmail.com>, 
 William Zhang <william.zhang@broadcom.com>, Nick Terrell <terrelln@fb.com>, 
 David Sterba <dsterba@suse.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Simon Glass <sjg@chromium.org>, Linus Walleij <linusw@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@kernel.org>, 
 Hauke Mehrtens <hauke@hauke-m.de>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Simon Glass <simon.glass@canonical.com>
In-Reply-To: <20260121-dt-mtd-partitions-v3-0-ec3af93c8f93@kernel.org>
References: <20260121-dt-mtd-partitions-v3-0-ec3af93c8f93@kernel.org>
Subject: Re: [PATCH v3 00/10] dt-bindings: mtd: Partition binding fixes and
 restructuring
Message-Id: <176909094128.3112602.14299487418440318214.b4-ty@bootlin.com>
Date: Thu, 22 Jan 2026 15:09:01 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 21 Jan 2026 13:56:33 -0600, Rob Herring (Arm) wrote:
> The partition bindings fail to restrict undefined properties. This is
> primarily on fixed-partitions which can be nested and partition nodes
> without a compatible string. This series fixes those issues and then
> several problems exposed by restricting undefined properties. As part of
> this, the schema structure is reworked to follow more conventional
> structure of applying schemas by compatible and a schema only checks 1
> level of nodes (unless possible child nodes are fixed).
> 
> [...]

Applied to mtd/next, thanks!

[01/10] dt-bindings: mtd: brcm,brcmnand: Drop "brcm,brcmnand" compatible for iProc
        commit: 4db35366d6dcda7475b75887f89078a11fb2d89a
[02/10] dt-bindings: mtd: fixed-partitions: Move "compression" to partition node
        commit: 30f138c078525fc49b0694e879a1eb60eda437d4
[03/10] dt-bindings: mtd: partitions: Move "sercomm,scpart-id" to partition.yaml
        commit: ac83f4fa911dbe6b7ccadeb82c35f2e42d7ce2f1
[04/10] dt-bindings: mtd: partitions: Allow "nvmem-layout" in generic partition nodes
        commit: 9f30ba0a22b79d46689c686546fb3fea28d475a3
[05/10] dt-bindings: mtd: partitions: Define "#{address,size}-cells" in specific schemas
        commit: 002d2fe7992220fab57497d3d78de526982cf511
[06/10] dt-bindings: mtd: partitions: Drop partitions.yaml
        commit: 95af1e641b0f245d1d6820bb0c8696fa6a07f5f5
[07/10] dt-bindings: mtd: Ensure partition node properties are documented
        commit: 1eb9fabd52933cdf9be349de5391920fac4ed30b
[08/10] dt-bindings: mtd: fixed-partitions: Restrict undefined properties
        commit: 6ecd7715d64ee3bf0b55b374f731d1518b57bc81
[09/10] dt-bindings: mtd: partitions: Convert brcm,trx to DT schema
        commit: a1fa0f8ca1fb108d2cbf67fad8056f07bce898f8
[10/10] dt-bindings: mtd: partitions: Combine simple partition bindings
        commit: 125981ffa1674573d3a9200e72ed93a2270344b1

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


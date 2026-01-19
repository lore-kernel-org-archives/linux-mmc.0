Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C831229BDBC;
	Mon, 19 Jan 2026 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768819714; cv=none; b=HGS5xefd3AU+W0svNx2Kmy22KMvPNRF4IsKOQw2+DNqXcScCU28XCmEzpOhHMFi1Ud+GV1CHr7As/cYPiBSZGyGUBFXLoS+D3LfDchFjMJiImlWuYWjdicZV6gWkWOX6UuCCB1ZhSdnWwTtOf4msYkmC7nOOChsIb8J21f7eQwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768819714; c=relaxed/simple;
	bh=LesPQtP8nBpkLG5sVvumxxLxN/aDk/ihJRQImuDvqHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rbb2YcBHYhRzEMoDf9czALYkcKWuIY5cKyC7mtioxS5ZWsFUGVs+G3dpu4S5PHbN5Fry/AWpVTejW+AhehV5fcVrm7zzVn7hhVt6ggbKZTQ3AMTE09jiSQNvbeBqsHM9OFpZAHQk5jAgwU0tq8FFbN9e51ekkJayaCPcajRWa9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wUWGRqNr; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wUWGRqNr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 09347C214C4;
	Mon, 19 Jan 2026 10:48:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0A46C60731;
	Mon, 19 Jan 2026 10:48:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 389EA10B6AE98;
	Mon, 19 Jan 2026 11:48:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768819709; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LesPQtP8nBpkLG5sVvumxxLxN/aDk/ihJRQImuDvqHY=;
	b=wUWGRqNrXy5hT3TdOC5N3mfiMFCZP6/Udi6kKrjVnE95z5mWJZhp9InQhvokC7pwgnBP8m
	LugDc76PMnz/JhmSVqqQag4QrYorxiUAvI20ELl6MBRhwm5K30y03er9m/PJykETQg9uUB
	Sa8StQLeUw6KE0c3mHz4RxiAjpNsyyD/qbiINdBRWwy9Qq8Jfq16MInQjdm0sZswD0YPq9
	drezzbrbhBi1gyEFQ069+yw85vDbgzaY9Ybnhiodd1RE8D3bZo6mCHve/94NTmKLGUIEk5
	noPcSmsfNkPFUEx1slK4c6gj981LGeUvlj3byfOLjH3IZAx8R/D+lF5r2nWZ/A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  Brian Norris <computersforpeace@gmail.com>,
  Kamal Dasu <kdasu.kdev@gmail.com>,  William Zhang
 <william.zhang@broadcom.com>,  Nick Terrell <terrelln@fb.com>,  David
 Sterba <dsterba@suse.com>,  =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>,  Simon Glass
 <sjg@chromium.org>,  Linus Walleij <linusw@kernel.org>,  Ulf Hansson
 <ulf.hansson@linaro.org>,  Marcus Folkesson <marcus.folkesson@gmail.com>,
  Tony Lindgren <tony@atomide.com>,  Roger Quadros <rogerq@kernel.org>,
  Hauke Mehrtens <hauke@hauke-m.de>,  linux-mtd@lists.infradead.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mmc@vger.kernel.org
Subject: Re: [PATCH 00/10] dt-bindings: mtd: Partition binding fixes and
 restructuring
In-Reply-To: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org> (Rob
	Herring's message of "Thu, 08 Jan 2026 11:53:09 -0600")
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 19 Jan 2026 11:48:22 +0100
Message-ID: <87tswhswsp.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Rob,

On 08/01/2026 at 11:53:09 -06, "Rob Herring (Arm)" <robh@kernel.org> wrote:

> The partition bindings fail to restrict undefined properties. This is=20
> primarily on fixed-partitions which can be nested and partition nodes=20
> without a compatible string. This series fixes those issues and then=20
> several problems exposed by restricting undefined properties. As part of=
=20
> this, the schema structure is reworked to follow more conventional=20
> structure of applying schemas by compatible and a schema only checks 1=20
> level of nodes (unless possible child nodes are fixed).

The series does not apply cleanly, I tried mtd/next and then
v6.19-rc1. Can you please rebase it and fix the conflicts (at least 2
patches fail, and then I stopped)?

Thanks,
Miqu=C3=A8l

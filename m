Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703ED2D7B8;
	Sun,  4 Aug 2024 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722774293; cv=none; b=qfrVFiItUUs4DMOVXWu2KOj0TAkbXvK+IL5fYy0DX1cY3JS2J2oAWnVii0CiJn7VL4UmVezpOJ+Jt2ruORTebI5DcYiOxw7yRT3lUv3eM6Z9lPT7JK6IeDiw1BzrDVJdlN694Z3AWZo9wm16uAfo5bpkSzkjeRazAINLUpzzuls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722774293; c=relaxed/simple;
	bh=L0HvgUcTzvuY++NgzjIc33b0gY8p82E/q9HfyXR7HMM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=r0sZzGADqudBQiSxG9Ep9EABZk6Pb40NMdG6PFP+54B3ixuLAwDunPV+mdmUNgxFdtpGSkZ+nXRDV8Q66AuzjmpOvhr4UAT4LwJ/KpvBnsYbkfYpaJMNq4n+hYjwDZJ2Bb5QG50pTzifQDsxLAu+mfpOGfB/4OOxPWBGPIU6x48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPfBku7B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPfBku7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE18C32786;
	Sun,  4 Aug 2024 12:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722774292;
	bh=L0HvgUcTzvuY++NgzjIc33b0gY8p82E/q9HfyXR7HMM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=vPfBku7BbNkqVihw9JIw5JHXxeOgSqm9YubloUJMMoi3z/QBjenmzfVpAfAzOQ1KD
	 FH+oBT6KI7xstHlNmtfJgVvo2JFkberlKbI/apvOYqK9IYf0eYDmGXtTrbdAyiosbm
	 rLSLWoHJZNDxmJho4JKrAz20LiP5OQWwUS4fvoJ9BT6OouyVcU3N/UfsPVoAkzCJyz
	 HSf+hpItAPY9RfLx3TsWwmtgVMmrlISMP0tWfvN8H944+YEtFLdvCnxlkcPe0zDji3
	 TbODPpHp1L3Vh5ok6xIznfQ1iWq08a2RBnjMOLE9tIj5rnxgf5BaD8PfRPOp88sYRi
	 jXsLRTZiZvFPg==
Date: Sun, 04 Aug 2024 06:24:51 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Joern Engel <joern@lazybastard.org>, linux-nvme@lists.infradead.org, 
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mtd@lists.infradead.org, 
 linux-mmc@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>, devicetree@vger.kernel.org, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Christoph Hellwig <hch@lst.de>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, 
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
In-Reply-To: <20240804114108.1893-6-ansuelsmth@gmail.com>
References: <20240804114108.1893-1-ansuelsmth@gmail.com>
 <20240804114108.1893-6-ansuelsmth@gmail.com>
Message-Id: <172277429149.3783478.13649526225862642200.robh@kernel.org>
Subject: Re: [PATCH 5/6] dt-bindings: mtd: Add Documentation for Airoha
 fixed-partitions


On Sun, 04 Aug 2024 13:41:05 +0200, Christian Marangi wrote:
> Add Documentation for Airoha fixed-partitions compatibles.
> 
> Airoha based SoC declare a dedicated partition at the end of the flash to
> store calibration and device specific data, in addition to fixed
> partitions.
> The offset of this special partition is not well defined as it depends on
> flash bad block management that might require reserving additional space
> at the end of the flash.
> 
> This binding allows defining all fixed partitions and marking the last one
> to detect the correct offset.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../partitions/airoha,fixed-partitions.yaml   | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.example.dtb: /example-0/partitions: failed to match any schema with compatible: ['airoha,fixed-partitions']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240804114108.1893-6-ansuelsmth@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


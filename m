Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE1E33343C;
	Fri,  9 Jan 2026 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951066; cv=none; b=FOzGbg38XvISCjis2LblYkBDXqPNfffvGGR8727taPtD1tKLDkmSQxbOLgBPlcvyo+thQmgSceyOaIO7gj9wvkUgg7aqv2vom6T9GJgRSYPaj+wRoA1c4H79pYVqm2RWbSOB/7i8OD9a21zn3HR8jTcu0mBgflGcMXNquuEbXlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951066; c=relaxed/simple;
	bh=MIKc/r+xHdWmFPm5tfPOSF/8DUVXSugT8lhEXzTHZJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCXAtZfFhJ8ETpYVwFmsUw2cDWHj7A1o1SUEYgERBQ5uhTTOXVXirPfRYZrIeGY1I9Lq1huDWtCikGvruXkGoEHCiWZW4kphI5gWYNIYfzkMjLjHJgnNxFsyr+GC+AS6tAqvRq+lVvOuci91qmfpHA1xNViyT8YNbkkE+OWgFoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q40zQrnR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q40zQrnR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF3DC4CEF1;
	Fri,  9 Jan 2026 09:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767951065;
	bh=MIKc/r+xHdWmFPm5tfPOSF/8DUVXSugT8lhEXzTHZJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q40zQrnRJ4ZiaZjp8Ifd5UpPCbKVjYlLrTsIQ0orcgazLQTW4QcfYH6oOf+XX8Ie3
	 BbIa/NyUXwjXwIQ/cUfx2kvjO3BvV7NZ8lSTkOVV9oBBWgyZc/nBWvlXJNqLRsccHD
	 UYIDSswxlpKAIaXGJOcU3l/JKYsxgOoUwGmkzY+9c66v02VOObq8XgJGF26dIZfW3s
	 iXS+m6ZDd6AElCvT7xzMhEJKAxqT/YH35/EfJ+3REQTYV99/jrmQRc6D36ytQDAQuy
	 s9/yYJKKuUQczsvSQt75YoQcD+qKGheHqVduKqDkuA7NSjGx2MSsDNwMigVvcAvI06
	 KmPN7WoNXcHzA==
Date: Fri, 9 Jan 2026 10:31:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Brian Norris <computersforpeace@gmail.com>, Kamal Dasu <kdasu.kdev@gmail.com>, 
	William Zhang <william.zhang@broadcom.com>, Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Simon Glass <sjg@chromium.org>, 
	Linus Walleij <linusw@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Roger Quadros <rogerq@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>, linux-mtd@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 05/10] dt-bindings: mtd: partitions: Define
 "#{address,size}-cells" in specific schemas
Message-ID: <20260109-crouching-alligator-of-ampleness-aca683@quoll>
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
 <20260108-dt-mtd-partitions-v1-5-124a53ce6279@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260108-dt-mtd-partitions-v1-5-124a53ce6279@kernel.org>

On Thu, Jan 08, 2026 at 11:53:14AM -0600, Rob Herring (Arm) wrote:
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml b/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml
> index e3978d2bc056..dc6421150c84 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml
> @@ -28,10 +28,6 @@ properties:
>        device. On a flash memory with 32KB eraseblocks, 0 means the first
>        eraseblock at 0x00000000, 1 means the second eraseblock at 0x00008000 and so on.
>  
> -  '#address-cells': false
> -
> -  '#size-cells': false

That's probably separate commit. These partitions never used child
nodes.

Best regards,
Krzysztof


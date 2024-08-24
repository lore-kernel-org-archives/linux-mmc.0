Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A42E14D6E9;
	Sat, 24 Aug 2024 05:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724476706; cv=none; b=bx6nKEfCCMXercvncMLPWH6LLr4Acmmx+mhylb94OaOavni+BGnntWj8BI0Od6F3+RWvpj9peXell94rF3EHpVePgluozOEvP0DKupqYZ58WfIW3LPI+dzMvWHrgTaSNTQoK9nF5w0dfXE7WdKLb3+pzs9f0ohV4475AWAgADXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724476706; c=relaxed/simple;
	bh=O1B7+CmSHgW5HOIQKy1tylg4RwfZLOU9zyiktNWEhuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuwHwxuiZS1iivnjoTfKeNPDrC+Kc73gRpPA7F574dTH2IrKCbjAvKHqqQ6w/35pmANU4Zf0OZ2bhJzpKCN4B2i7oAPANcbawmooXzq/7U6oRH0uE5jEgcbEa1lvFEJeBotX3YC8b6lcvV1lPk59b7PDcu18ze887gg909hcmtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GyVegh1T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GyVegh1T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BEBC32781;
	Sat, 24 Aug 2024 05:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724476706;
	bh=O1B7+CmSHgW5HOIQKy1tylg4RwfZLOU9zyiktNWEhuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GyVegh1TQfQYO2n/6SrgHILMFuu/1wuXh2XhuVD7OwJDNY0p02JvTVRZHAlJfAZm6
	 G71zAD5P88vdUeihb9eMM1v7o5k2YoGZSjKA6pJst9viFIcYrAoY0CKDYE6ovgPGj+
	 RzyzsNNIa1yhddCzsmPDAutoeQkZm7E0zQo29iLw=
Date: Sat, 24 Aug 2024 11:13:12 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Manuel Traut <manut@mecka.net>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v9 1/4] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Message-ID: <2024082403-preseason-preacher-a709@gregkh>
References: <20240814153558.708365-1-jens.wiklander@linaro.org>
 <20240814153558.708365-2-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240814153558.708365-2-jens.wiklander@linaro.org>

On Wed, Aug 14, 2024 at 05:35:55PM +0200, Jens Wiklander wrote:
> A number of storage technologies support a specialised hardware
> partition designed to be resistant to replay attacks. The underlying
> HW protocols differ but the operations are common. The RPMB partition
> cannot be accessed via standard block layer, but by a set of specific
> RPMB commands. Such a partition provides authenticated and replay
> protected access, hence suitable as a secure storage.
> 
> The initial aim of this patch is to provide a simple RPMB driver
> interface which can be accessed by the optee driver to facilitate early
> RPMB access to OP-TEE OS (secure OS) during the boot time.
> 
> A TEE device driver can claim the RPMB interface, for example, via
> rpmb_interface_register() or rpmb_dev_find_device(). The RPMB driver
> provides a callback to route RPMB frames to the RPMB device accessible
> via rpmb_route_frames().
> 
> The detailed operation of implementing the access is left to the TEE
> device driver itself.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Manuel Traut <manut@mecka.net>
> ---

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

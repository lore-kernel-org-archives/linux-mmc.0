Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699BA311C18;
	Tue, 12 Aug 2025 06:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754980411; cv=none; b=MovIxXLjMtuBjNR43S1HTMdCxfFqYBNTL6uI6rbDvvdlEn9QRDEtl+5+HndRGHUeuXJGflIGDJBSSR3YyIVHof/ineqbBrXuv/uyL/rVqRGUIKkfLou+iI+9M2CWzALd7GfO0QsTxmuNPD56EroVZE65Hqvm1D6rkLK9H6Tprf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754980411; c=relaxed/simple;
	bh=qVnNl5Aa1AqrdQltdw7jc64sazpLHzw50yn2eieZsrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdEtfOUQhSQ8ko3wocrJP7nxpSiC8fU/JUZMkv5GVbLuEbi5XYUvHJQtrzohcaRsSlXKsviHtx0r7pFd/yf3fn1dnr35Q4r+4UcCpUuDAJfyXDeVC4206G2Ar6PMoINMWHHF7fIsoa+tWcE/mJg77IJ9j+6qfMroD2ED2x7yplU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I5ymBM5Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I5ymBM5Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9799FC4CEF0;
	Tue, 12 Aug 2025 06:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754980411;
	bh=qVnNl5Aa1AqrdQltdw7jc64sazpLHzw50yn2eieZsrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I5ymBM5ZdD7q/tgZ44R5fFcZLu/jX8/fZK6l/SXuDZ4GymFB/jWtibNAVJLKSXLra
	 qJK+qwbb7AHdpBQ1kX0gyoBb2iNghZKzRe3whqMEGMaCB1PCWEsZmKSvbiX7UvZZpM
	 I2Y24C71GQ5K7thacv94Pm9J28KVaoqaNYnPLPRI=
Date: Tue, 12 Aug 2025 08:33:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ricky Wu <ricky_wu@realtek.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, arnd@arndb.de,
	chenhuacai@kernel.org, ulf.hansson@linaro.org,
	maximlevitsky@gmail.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] misc: rtsx: usb card reader: add OCP support
Message-ID: <2025081206-laxative-droplet-c9aa@gregkh>
References: <20250812030811.2426112-1-ricky_wu@realtek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812030811.2426112-1-ricky_wu@realtek.com>

On Tue, Aug 12, 2025 at 11:08:11AM +0800, Ricky Wu wrote:
> This patch adds support for Over Current Protection (OCP) to the Realtek
> USB card reader driver.
> 
> The OCP mechanism protects the hardware by detecting and handling current
> overload conditions.
> This implementation includes:
> 
> - Register configurations to enable OCP monitoring.
> - Handling of OCP interrupt events and associated error reporting.
> - Card power management changes in response to OCP triggers.
> 
> This enhancement improves the robustness of the driver when operating in
> environments where electrical anomalies may occur, particularly with SD
> and MS card interfaces.
> 
> Reported-by: kernel test robot <lkp@intel.com>

the kernel test robot did NOT report that this driver was lacking this
new feature :(


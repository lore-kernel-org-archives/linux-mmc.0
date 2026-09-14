Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00588352017;
	Mon, 14 Sep 2026 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388810; cv=none; b=GyX9AshAjaf+cslR2jOq2/1GT6ux8reWjm5WV58dT40bUXe/tXkLHCwyohvFJS+jTUZOu3mcnbx2wY2W+x24OXy3UONZ0x4tkopyhOHIiW69yoBXYalZATEpO3g66ZK8vGOUVo2EnXqxjH78AMHP+28EtcOypYtHnbuVlRckJGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388810; c=relaxed/simple;
	bh=emtcRfKafAv/TOF84LPDh6ctNyV501zeDE0RAvj2NuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOivx8CZDJHp/gyZ4fSvHUNqZ8sUyO6lzJOKomXQmWNmP7a5ZLb5AeyaBgbNe1z7t80GS0hNqLlzE/Okb4SDF4fmlQr3Nal+uIWun/g8Z2BOhe+hxv3W6Whz4v5+c/FtWIplLs81aFIfPfIt+upsWq53fjXMYEo254lDjjcAlM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNorBkNX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNorBkNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34C81F0089D;
	Mon, 14 Sep 2026 12:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789388807;
	bh=xST1Tb/dx3nJmgTQfutJVEnulduFhsjDg2d9IGkl2jA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NNorBkNXvVSeUD97uBQ0FYq7kJIqNNhe3e8/+KXbW0T+h5NfqgfYNgTHTLoRNrHf4
	 FfdLmamPN99ATF1BDUvPPYEydAhaVIbvxaMx7af2Troh7h9tcMsxtWwvCbMsNnAaio
	 PcY507bEhBKJ3RUd2LPlpz5Jx3NNqZFKqyUe/fWVQ8nEkzEqeuKWz6FN4caRuc1Vx5
	 dQE+6uWoTV/g/4Ww/9VtKF69I2hT79bR6wHuHzbTXNquQOwCqy3u+8mWz00kIGYom2
	 cYVTCmbFox/jwsGCbqQ0Vrowl+0Fq8ulJHlZWFjL8V7PZPs1jnxKGsNZwy8Jvg7H6r
	 9w090PxeeSb1A==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x65ll-00000004IYv-0sBX;
	Mon, 14 Sep 2026 14:26:45 +0200
Date: Mon, 14 Sep 2026 14:26:45 +0200
From: Johan Hovold <johan@kernel.org>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mmc: vub300: Remove the driver for the obsolete HW
Message-ID: <aqfoBfYmJX2XUA2N@hovoldconsulting.com>
References: <20260914111642.169707-1-ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914111642.169707-1-ulf.hansson@oss.qualcomm.com>

On Mon, Sep 14, 2026 at 01:16:42PM +0200, Ulf Hansson wrote:
> From: Ulf Hansson <ulfh@kernel.org>
> 
> The Hw is obsolete since many years and its corresponding driver has not
> been actively maintained for a very long time.
> 
> In this regards we are lately receiving a lot of AI generated bug fixes as
> the driver is a real mess. Rather than continue this path, with small fixes
> instead of making a proper rework of the driver, let's just remove the
> driver altogether.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Johan Hovold <johan@kernel.org>
> Signed-off-by: Ulf Hansson <ulfh@kernel.org>

Acked-by: Johan Hovold <johan@kernel.org>

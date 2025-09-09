Received: from mail-m3276.qiye.163.com (mail-m3276.qiye.163.com [220.197.32.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827B0DDC5
	for <linux-mmc@vger.kernel.org>; Tue,  9 Sep 2025 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405287; cv=none; b=dtC//iXsAQOMn9a1Y8o6QOY2RkWPJ0JRrkQko3AiedYH0V27qT8As1Wjtseb96ws4yX+S8YpZsqlA4pr6NlUuyapBTo0O9uRnkbvhYuKOpDuyAa7TKV3fv47/0xi2Ugb+MAqAlR72kDOkj2YijnDEtO+SR7pBjmXQn/BGyHEXzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405287; c=relaxed/simple;
	bh=a/QOqYXmEspBuYHF6FVrmYpdfOvNEntqRxdbRlMANPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9cp46hYb/H8Q7zKgNvZycyZTVHKLQ8Ifs0AI98xRWOP3Vn8rB6HDRqXrtHt8xmHWjHwV/nG8fZjLeWaUDo+jQLppz7dGQSV1AhMKSKKpNTs2wTF26gJJEw6y1F0SYzBW7DUuwnN32HjAwGIJyj0Dmi/+tXM3qbQM1AtxeeqVEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=eLqRYTdG; arc=none smtp.client-ip=220.197.32.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="eLqRYTdG"
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 222e0b253;
	Tue, 9 Sep 2025 16:02:46 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com,
	arnd@arndb.de,
	gordon.ge@bst.ai,
	linux-mmc@vger.kernel.org,
	yangzh0906@thundersoft.com
Subject: Re: [PATCH v3 5/8] mmc: sdhci: add Black Sesame Technologies BST C1200 controller driver
Date: Tue,  9 Sep 2025 16:02:46 +0800
Message-ID: <20250909080246.2264646-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAPDyKFon7Q2UHOJbbVtPTHvqxYeOJr8HK5BOk6TAJaph8FcwvQ@mail.gmail.com>
References: <CAPDyKFon7Q2UHOJbbVtPTHvqxYeOJr8HK5BOk6TAJaph8FcwvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a992d7fae6f09cckunm58df28de1956ff
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHU5PVkIeGUwfTx1LSU4dGlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSEJVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=eLqRYTdGv6Mf7+7MHTuDBWMDyy8shCRWYHtblw1rx9N8zx3R0pu2DjmGLK5uSt2sUnOxTpkZ1MGypRelRqBxSXVoW1pM2z+WHctun6EyBhTei0vg5F8tD1FxqnbFIVMHoHBh9vksn6zFXLTJ6CycMqwwIBDOv98jOY6b7R7okZY=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=FZ7GvwEcsA9lONXq4I/WPg9ctUxXMmG6MT/NeJQEDck=;
	h=date:mime-version:subject:message-id:from;

On Mon, Aug 18, 2025 at 12:48:39PM +0200, Ulf Hansson wrote:
> On Tue, 12 Aug 2025 at 14:31, Albert Yang <yangzh0906@thundersoft.com> wrote:
> >

> > +               timeout = 20;
> > +               while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL)) &
> > +                       SDHCI_CLOCK_INT_STABLE)) {
> > +                       if (timeout == 0) {
> > +                               dev_err(mmc_dev(host->mmc), "Internal clock never stabilised\n");
> > +                               return -EBUSY;
> > +                       }
> > +                       timeout--;
> > +                       usleep_range(1000, 1100);
> > +               }
>
> Please convert into using some of the readx_poll_timeout functions
> instead of the loop above. Moreover, please add defines to specify the
> period/timeout.
>

> > +       while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL)) &
> > +               SDHCI_CLOCK_INT_STABLE)) {
> > +               if (timeout == 0) {
> > +                       dev_err(mmc_dev(host->mmc), "Internal clock never stabilised\n");
> > +                       return -EBUSY;
> > +               }
> > +               timeout--;
> > +               usleep_range(1000, 1100);
> > +       }
>
> Ditto.
>

Thanks for the review. I have created a new static function as suggested:

static int sdhci_bst_wait_int_clk(struct sdhci_host *host)
{
	u16 clk;

	if (read_poll_timeout(sdhci_readw, clk, (clk & SDHCI_CLOCK_INT_STABLE),
			BST_CLK_STABLE_POLL_US, BST_CLK_STABLE_TIMEOUT_US, false,
			host, SDHCI_CLOCK_CONTROL))
		return -EBUSY;
	return 0;
}

And I will replace the code at the call sites with the following:

		if (sdhci_bst_wait_int_clk(host)) {
			dev_err(mmc_dev(host->mmc), "Internal clock never stabilised\n");
			return -EBUSY;
		}


Best Regards,
Albert

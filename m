Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E6033CEB5;
	Fri, 27 Mar 2026 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774608740; cv=none; b=NaexBMwvhGerbhmQU0+Z0Tz7+UyzLcxHUt149EqYQC6WJL4emf7nrVHtK+g9KsX5z9IcptYVuGb/diPEvXhhplk4LboZVMwrqfKi3OsqGyRiAToyJul7nshlohNuw2qsVwbv5SHztXqDBmlJlZ7p6L2K3S42fmMYxxjlBHBSjFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774608740; c=relaxed/simple;
	bh=8/rZ9ti1pgZ6fTmi088Bgv37LPpqrgewVTXJEcGJcb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzOBba6fgBtOWnzh8Ie4qwmAkEyBJJmIPjllF0fgRcozi6A8CT7DXDORJgIbX79YbJYzCACGNbjVuveWpESQaOxg7SUjRfoKde2rdrXWWzj1Yce9s2WICV3orCdKpl7BQ5yejjfCkfB/UbqDwft+CPRHuSvlxsAu7Yx/uKANMaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lk/v/CYd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lk/v/CYd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58ACEC2BC87;
	Fri, 27 Mar 2026 10:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774608740;
	bh=8/rZ9ti1pgZ6fTmi088Bgv37LPpqrgewVTXJEcGJcb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lk/v/CYdZcEEs3K51N7EJ0iv+/sDOlVtIZtNlhmOIrxliny8GtEC3o7CFnF4vELLf
	 Qt4J2lWR9PAcTldcZSLKPT1sKXVHMyLw5ELZkGVpsKloV5EUouFlTMkbzk1JkKH1/V
	 YA6T6cURPFzVTJxl+YqvsnRMz/8921+FQhhPvvGI0mlb+4WO/En3RsV9MDRa4c+lV+
	 55qC4ylM4qOZKcyhM2iiDzkyO3YofeQyRGADcnJXyI9Dwgmjtcc1LMYFi/dzeTPzdQ
	 +DOegB0v69cm1+e4DAquTREz+DpDysaVaE4umip28LuUsoRm+J9aGl+1I/3e6fcwys
	 a5VXERkgCjfEw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w64na-00000005UzY-18wW;
	Fri, 27 Mar 2026 11:52:18 +0100
From: Johan Hovold <johan@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/4] mmc: vub300: rename probe error labels
Date: Fri, 27 Mar 2026 11:52:07 +0100
Message-ID: <20260327105208.1310739-4-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327105208.1310739-1-johan@kernel.org>
References: <20260327105208.1310739-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Error labels should be named after what they do.

Rename the probe error labels.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/mmc/host/vub300.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 3c9df27f9fa7..3057a69ff8c4 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2107,19 +2107,19 @@ static int vub300_probe(struct usb_interface *interface,
 	command_out_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!command_out_urb) {
 		retval = -ENOMEM;
-		goto error0;
+		goto err_put_udev;
 	}
 	command_res_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!command_res_urb) {
 		retval = -ENOMEM;
-		goto error1;
+		goto err_free_out_urb;
 	}
 	/* this also allocates memory for our VUB300 mmc host device */
 	mmc = mmc_alloc_host(sizeof(*vub300), &udev->dev);
 	if (!mmc) {
 		retval = -ENOMEM;
 		dev_err(&udev->dev, "not enough memory for the mmc_host\n");
-		goto error4;
+		goto err_free_res_urb;
 	}
 	/* MMC core transfer sizes tunable parameters */
 	mmc->caps = 0;
@@ -2336,10 +2336,11 @@ static int vub300_probe(struct usb_interface *interface,
 			 interface_to_InterfaceNumber(interface));
 	retval = mmc_add_host(mmc);
 	if (retval)
-		goto error6;
+		goto err_delete_timer;
 
 	return 0;
-error6:
+
+err_delete_timer:
 	timer_delete_sync(&vub300->inactivity_timer);
 err_free_host:
 	mmc_free_host(mmc);
@@ -2347,12 +2348,13 @@ static int vub300_probe(struct usb_interface *interface,
 	 * and hence also frees vub300
 	 * which is contained at the end of struct mmc
 	 */
-error4:
+err_free_res_urb:
 	usb_free_urb(command_res_urb);
-error1:
+err_free_out_urb:
 	usb_free_urb(command_out_urb);
-error0:
+err_put_udev:
 	usb_put_dev(udev);
+
 	return retval;
 }
 
-- 
2.52.0


Received: from list.virtualsheetmusic.com (list.virtualsheetmusic.com [170.249.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEEA1C6A1
	for <linux-mmc@vger.kernel.org>; Thu,  2 May 2024 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.249.201.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714633325; cv=none; b=P//E1i8Mn4a1B9idcUPZbdqTDm0Q/qgai0dL1ShAqhLOQBT3FUGQqF1Lm4TJ1vPPGf9LSfyvjddh6wVJF5FObIflavrpGU5r+ih9xqdbCi7bHej7VrxCwiTRlIfjcnN9GALD0lCfssC+tUxAdIezXGJk2k47jeusv5xgez5+tdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714633325; c=relaxed/simple;
	bh=aOOGdYfXz1IrjbLaH6tskIGPTvRasIQxz+fxJYBv3F0=;
	h=To:Subject:MIME-Version:From:Content-Type:Message-Id:Date; b=fkuHW1d2S4zr5QtCnx1aucAR9Gv9oEo2u9DQqEu4NkWGkoOt+K+4ebueYAJGEIEJlInrF1t1I3pwIla7AmlqO9180SZeuWQl+JuRrVSC8o1GQUw7hLZGsfpF+X7HUs3sVFD42cb8SGnnjTR04sRxEecTOWO8gcgdgri8hdYK8NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=musicianspage.com; spf=pass smtp.mailfrom=musicianspage.com; dkim=pass (1024-bit key) header.d=list.virtualsheetmusic.com header.i=@list.virtualsheetmusic.com header.b=izI7z4QV; arc=none smtp.client-ip=170.249.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=musicianspage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=musicianspage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=list.virtualsheetmusic.com header.i=@list.virtualsheetmusic.com header.b="izI7z4QV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=list.virtualsheetmusic.com; s=y; h=Date:Message-Id:
	Content-Transfer-Encoding:Content-Type:Reply-To:From:MIME-Version:Subject:To:
	Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=aOOGdYfXz1IrjbLaH6tskIGPTvRasIQxz+fxJYBv3F0=; b=izI7z4QVGIv6
	chUo+vHXkh9tvI4UQUyATtb1RvN8r9oCB91iXoNLZYdQEKWcohgdlpKk0F3nDMPc8zb540UAultam
	HZ9aaXSeEBONVLxUiq9Lo7jt8OETedY60HPoInIhj3zCRF1RC1o+OzJno3tYRraYKEw1vYxvtgm2q
	Y0+IU=;
Received: from root by list.virtualsheetmusic.com with local (Exim 4.92)
	(envelope-from <no-reply@musicianspage.com>)
	id 1s2QS9-0000OO-Jv
	for linux-mmc@vger.kernel.org; Thu, 02 May 2024 00:02:01 -0700
To: linux-mmc@vger.kernel.org
Subject: You subscribed successfully.
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Musicians Page <mailingconfirm@musicianspage.com>
Reply-To: Musicians Page <mailingconfirm@musicianspage.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Message-Id: <E1s2QS9-0000OO-Jv@list.virtualsheetmusic.com>
Date: Thu, 02 May 2024 00:02:01 -0700

Dear Musician and Music Lover,

you have successfully subscribed
to the Musicians Page Newsletter.
It will keep you informed about the latest
information about music events, site updates
and news from the music industry.

You can personalize your Newsletter at any time from the following link:

https://www.musicianspage.com/em.php?email=3Dlinux-mmc@vger.kernel.org


Remember that our staff is always available to answer your questions
or help with any problems. For assistance, just send a message to:
mailto:support@musicianspage.com.

We always strive to help you in your musical pursuits.

You can unsubscribe at any time by clicking the link below:

https://www.musicianspage.com/unsubscribe.php?email=3Dlinux-mmc@vger.kernel=
=2Eorg


Thank you very much for your interest.

My kindest regards,

Fabrizio Ferrari

supervisor
Musicians Page
https://www.musicianspage.com




Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A732309B9;
	Sat, 10 Jan 2026 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768058893; cv=pass; b=fTCZnjtvLbyYO5kNDzMyXl2/SMdw+ov61N9faIM+5jujLDEHfPdPzKNJtiZAUFpTeL822U9mNE6KrxGbT8ZWhywlvyIzw9ADflt8GvYiRgbfdCKXiDIelk498rd0xpDAb4E0G9fTVFbeBfVXFcpKEf5SV72iLgt0hg/m0Zf4GNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768058893; c=relaxed/simple;
	bh=8KCEdEkWM0mqnhK9qkpCNJLttodjgyO8awh0AV+CymM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VvINQXWecs6u/C1tiKNRiP+2C8AxeXrNa/QTPISz3kqhUTLRnSuNFi/rBVUVakR/T4ADha1pNrM4CtAgShTqPqNCD2oKAe68Zp2yeCqD1Vk8ebPz/Xs4wyjQVsXh6H+L/KFmqvrufHQnSYBd9s1sjwQ6rZ8R3Xs+/7mOgA6uKnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=eO6TWSG3; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=W4aJjXFj; arc=pass smtp.client-ip=185.56.87.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="eO6TWSG3";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="W4aJjXFj"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-lgnf.prod.antispam.mailspamprotection.com; s=arckey; t=1768058892;
	 b=Xx5JvvVlccOwXBYDilwPMnjySOWMPr7Zy7ZpwtYqcLqv3G4IN3T8MPU1+lnvPZVYAktFvI6Wmf
	  dAZU0jYzSLfkkx+8YfD3YFuWXIW2TrhuV9FN8r2sDtby0tRDveGbgj5rnwFujkpEtOXUkg631Y
	  W4eM2w2ki2CWd51L01s0+9HA0iO7pVt2bnAeBsDHzu52wbt5lXC5nUqiGHLTJu59HPPCRquEJZ
	  mzP4pz4dcgFMoP/Y+9a0iPXj/suIOCXnDV70SaIqQt9AqFQ/0cXLjY6GYPaI0heZdq6Dn63NZk
	  pb1/7MS7OSm4jtBoG51xL0sO2DTnLtjMV7IyK8xAkUvc3g==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-lgnf.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-lgnf.prod.antispam.mailspamprotection.com; s=arckey; t=1768058892;
	bh=8KCEdEkWM0mqnhK9qkpCNJLttodjgyO8awh0AV+CymM=;
	h=Cc:To:Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:
	  Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=XlD8sDjbPNQ35imJASNaTEJbfAk9HKv7OXrZwUo/E1MmXqYCASzrpLqR/GBuQJOrYPkcHGUmHG
	  iZ5TCSLSYTUeT20MHt9lTUg5nZd2Fb7GrZLPWnPH2daMcDfb+LiOh0WOmDNaW2yQsnkNOTL3Dl
	  Z4VAdFJSSC0CNFntRNIP/3FVXuM0N4VrgeMpe2SzwtOsprorSd4phskDgvZG27cATRV5DXIl47
	  kOSBmsXZu4FJ8ZtBEp0y7PFrrFzs61TJE6Yc9GRWCkF98EFTYBrYCvUaIDigZksru5O5v3EFA6
	  L4xhHye7zv2U1cQa32QSzHUfsHWQer1HbOytUQaq+pl/BQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=AeqCUJ0ehAF7zzlRecyn5PtT4uvT9dPYj5B/ComXNFs=; b=eO6TWSG3NgW6oDGPkE6qLDLwHE
	izSDpfqW1tg8z97/GikL1THy+xqb2FYleiMlUxdCdN01VIXVOpK9lfPNHvuqhzUUEnndEA2J3Li3Y
	1vvBpk1f6IGXN/GbVST4uxUOlj+Raz2aLcEYwJ9Xg5IbPeEwfHR/6ASUMEY/mKULMMfg=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-lgnf.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1veasp-00000000c11-09N9;
	Sat, 10 Jan 2026 15:28:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=AeqCUJ0ehAF7zzlRecyn5PtT4uvT9dPYj5B/ComXNFs=; b=W4aJjXFjAQ0seMncIQSh6sl6RB
	5BDxwK3Xk6AoW8BZUYoC9NRf+rW2Am70dXbeXEvgHvJ3keTW9Wh5vbFYPwrXsRFc2KWuJhk23IWuJ
	q47N+1C6NTt8OC/A5taN3W0aG7642dQXntOEZlg4QdSu4YJ5UAFWsWouWC2g01bfsJW0=;
Received: from [95.248.141.113] (port=63559 helo=[192.168.178.65])
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1veasj-00000000ODh-1OLP;
	Sat, 10 Jan 2026 15:28:01 +0000
From: Francesco Valla <francesco@valla.it>
Date: Sat, 10 Jan 2026 16:27:59 +0100
Subject: [PATCH] of: property: fw_devlink: Add support for "mmc-pwrseq"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-mmc-pwrseq-v1-1-73de9d6456f4@valla.it>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zXMQQ6CMBBA0auQWTtmWgNUV9zDGNPWqTShgC2pJ
 oS72xBd/sV/KySOnhNcqhUiZ5/8NJYQhwpsr8cno3+UBkmyISEIQ7A4v2PiF7JSNTdta7U0UIY
 5svOfHbveSrs4BVz6yPpP1HQ+7cT9R2SJAhVpZRvD5Ax1WQ+DPvoFtu0LET1PIp0AAAA=
X-Change-ID: 20260110-mmc-pwrseq-e885e677ca2b
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2653; i=francesco@valla.it;
 h=from:subject:message-id; bh=8KCEdEkWM0mqnhK9qkpCNJLttodjgyO8awh0AV+CymM=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDJlJBQxTmxJCHp+NTFMsFgtw4SqI3+ebJ3HX+zu7kNyz8
 pPHbht2lLIwiHExyIopsoSsu3Fvz1zzb2kbGB/BzGFlAhnCwMUpABPhtWNkmFIfkfTj0/TE2uyW
 ndfO6p7aJ9y85kjPyl7eibUH+HmUEhgZvm/QkDD/90z/Rvqb1rOaG0tsSuPW2J6RWWky57m37L1
 iTgA=
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: bf9b7b06305fd59b6927775fbbff7432
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1veasp-00000000c11-09N9-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-lgnf.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Add support for parsing MMC power sequencing (pwrseq) binding so that
fw_devlink can enforce the dependency.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
Resending this patch as it slipped through the cracks (of my attention,
at least).

Original submission is at [0]; there it appears as a v2 because it was
the first time I used b4. It was also part of [1], which wasn't really
a patchset but a follow-up to the boot time SIG meeting.

I added Ulf and CC'd the mmc list, hoping they can (more
authoritatively than me) reply to Saravan's question:

"""
I took a quick look at the documentation. It's not clear to me that
mmc-pwrseq always points to a supplier. Can someone with more
experience on this confirm that is what it's supposed to point at?

Meaning if A lists B as pwrseq, is it always the case that B needs to
be powered on? The binding documentation doesn't say anything about B
needs to be powered on first. It's just saying A and B have an
ordering requirement.

If the meaning of the binding is _ALWAYS_ B needs to be powered on
first, then yes, this patch is correct and I can give a reviewed-by.
"""

[0] https://lore.kernel.org/all/20250930-mmc_pwrseq-v2-1-80a8c6be0fb0@valla.it/
[1] https://lore.kernel.org/linux-embedded/20251126-beagleplay-probes-v1-0-c833defd4c9b@valla.it/T/

Thank you!

Regards,
Francesco
---
 drivers/of/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 4e3524227720a596b0f12976f83357851e9b94f3..05ae33a58b5aec0a8f4d3b7237ce88066d86dc9d 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1410,6 +1410,7 @@ DEFINE_SIMPLE_PROP(post_init_providers, "post-init-providers", NULL)
 DEFINE_SIMPLE_PROP(access_controllers, "access-controllers", "#access-controller-cells")
 DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
 DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
+DEFINE_SIMPLE_PROP(mmc_pwrseq, "mmc-pwrseq", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
@@ -1557,6 +1558,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_msi_parent, },
 	{ .parse_prop = parse_pses, },
 	{ .parse_prop = parse_power_supplies, },
+	{ .parse_prop = parse_mmc_pwrseq, },
 	{ .parse_prop = parse_gpio_compat, },
 	{ .parse_prop = parse_interrupts, },
 	{ .parse_prop = parse_interrupt_map, },

---
base-commit: b6151c4e60e5f695fac8b5c3e011cfcfd6e27cba
change-id: 20260110-mmc-pwrseq-e885e677ca2b

Best regards,
-- 
Francesco Valla <francesco@valla.it>


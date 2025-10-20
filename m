Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EB8246768;
	Mon, 20 Oct 2025 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966552; cv=none; b=jnqYRwPpJSgpq8WbccdJTd2GoGtXQ5VmyPqt9BWDQGpqoKe+5J7fIj6vUKHh7O2zKJ2HtdPbV27aAwLxn/fLqqiENOHTpbhykUw1sMOgJURHobZR7v9Nwnb7v8rAg5QjEe4jSfauam7cCExPZy10GIMZqoB2tj6WpbB5U5P5yL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966552; c=relaxed/simple;
	bh=g9yF4NmVFXBU7EcIv5/phjwGgScF3AY5Gk/OHmdnFBk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NaGcF1EZLPgpa4F1w6Zrh9MgNmy7fbkeNJPSl4WpLtY68koMF1Ui2OVILwHZhxdYkBVETHgNSbsUCbq23RiynM4ZXzOClxuBQNjxjFmmIhcwVZ7SPLMgz4scpt8BCNwdNo3hvjdU7gvMKygDQ6MdTmoDCb1xiDHZJSNwkYwNbc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=s2iaU/9a; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="s2iaU/9a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760966540; x=1761571340; i=markus.elfring@web.de;
	bh=zSB8KHT+GOhbNxLAc0qbb+e5oJUxj8h6ZeX1Dtcpyuo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=s2iaU/9a5LnBil/mNsaoejK8x8D7mgB3R11bCHtfsqn8mUGSmkyp+GllCM8to1KZ
	 mltvJIwKEiPk8pArO1zTh3d7RsWNNuwz/meCN15vF9ifUr7YzIAyfEZPx/eVBhKd4
	 xwBcD0uYXwGgZJAlYr+J1iV/iRZgvSkpCIusb2oT0uY2wXPvcWzTpjbq/p+fdcxId
	 PfxKSSlX6KgbriCkgy2zqY8xk8oj8n6Gc5a4w4bMIOJcAQsyd18VFrkfrOwbgqhRr
	 Ckow0JzlPsq1ceOWwCCtl+SwER0/mXXYpI3AGi3k1EoHyb5AZ6iC/Ksfs9Qft6z3g
	 gQYzyyg0enPl4gjlZQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MA4bA-1v3eqM1hla-003uiA; Mon, 20
 Oct 2025 15:22:20 +0200
Message-ID: <5fc18699-74ae-4f31-8794-bcbdc5ae6008@web.de>
Date: Mon, 20 Oct 2025 15:22:18 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, Anand Moon <linux.amoon@gmail.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] mmc: sdhci-of-arasan: Omit a variable reassignment in
 sdhci_arasan_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PY7MIUXbyFhk5SPT0mC45Ilytt1TY+Cspgd9JfsCsX9wU4/RgEY
 zDKRvvBbTq9Yrl5QqaaJwGfB6qGd1rPOc5D0C8mjDzCV7zY/vNltaXd766wO6XVMCzY8Rh1
 TAmWg8/yUVkWEHj8D4cDo2BnkqBqpZ4vLshlaBzuz1bcHB13qbS86oucxMyEUfkQ60YA0bL
 vQOD/fQgWWvDir4JfXZJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BgYjSJA7rV0=;jJwnfbRfBKKyX2Am5V5hzBYf19k
 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
 mMyjtOeV0bpuXD2yMertv2XmXEqccaRc/+c=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 20 Oct 2025 15:15:07 +0200

An error code was assigned to a variable and checked accordingly.
This value was passed to a dev_err_probe() call in an if branch.
This function is documented in the way that the same value is returned.
Thus delete a redundant variable reassignment.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/mmc/host/sdhci-of-arasan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-o=
f-arasan.c
index c6f09b53325d..b97d042897ad 100644
=2D-- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1991,7 +1991,7 @@ static int sdhci_arasan_probe(struct platform_device=
 *pdev)
=20
 	ret =3D mmc_of_parse(host->mmc);
 	if (ret) {
-		ret =3D dev_err_probe(dev, ret, "parsing dt failed.\n");
+		dev_err_probe(dev, ret, "parsing dt failed.\n");
 		goto unreg_clk;
 	}
=20
=2D-=20
2.51.1


Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE8B1FE450
	for <linux-mmc@vger.kernel.org>; Mon,  2 Dec 2024 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140314; cv=none; b=rXk/xhxnibiKqX8mtnMY83H/oAlkvIJkwnt1OjI4YmCI71uQvwJgIGDQn43tQ7B7P5xBP+fluz6kPrLUX96Mi4EV7xeXSID4tVPf/2bvicdparfMynM4c8lqcLMzVkIzirJHqla4PtUAuPcyCtpC/SyzHd/jhe1PU6HBR0maamo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140314; c=relaxed/simple;
	bh=pbjUrED4i5J0KfHWo07UKGPllLu4KTU/YCZqt+0bfqM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TR7tP4bx98s5zRQZX0p/7vDf1i681JnU06d5kxei3j4N9XE2/KwO/xbj2LaluJSeO3LJF2obisdLsP/gzideda13z6cptkzL6k8DFlL20QAofGkzye1QASqk8BdEehy0KT7OxlgQU0Z83SPnJbco1VggY0epAE88SO8WTmcLomg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=E8OL+bxd; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="E8OL+bxd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1733140303; x=1733745103; i=wahrenst@gmx.net;
	bh=ibzrOEjWbR+1FpvncmKtT0ZNKhHCYtX65cHqDPNlL+Q=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=E8OL+bxdmisiKII6du+EsnYaVhY78A0iiu0dF/PcWG9SJzQyQqCARHeAav1QXKYW
	 LAIynIUTPRWTGLINv8t9S2/BA7vt4htvSWxr4jo+NS8isDFeBjxttS4XIYNm6preq
	 b2/qDW/Vjd3oOZqap6kwvUxe+y9jV7pVjy8v39mQMlfwR+cKr6TGvBlP+LLiNEx6l
	 8yN2AL78RApCRb/WmrDrA425DcsniGDm5+hhGHrwrST9MgzN18FP+808koTb4lwVE
	 armC5k90R0tzf/xvmuPdVXTOxTK3ggYhoEKbEBOO8fIRYz8Y+9sP6xejyReLKfPIr
	 HYEqurJm9Hm67S433w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.251.153]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYeQr-1tE2M026pH-00O3QS; Mon, 02
 Dec 2024 12:51:43 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Lukas Wunner <lukas@wunner.de>,
	Peter Robinson <pbrobinson@gmail.com>,
	"Ivan T . Ivanov" <iivanov@suse.de>,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-mmc@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V6] mmc: bcm2835: add suspend/resume pm support
Date: Mon,  2 Dec 2024 12:51:40 +0100
Message-Id: <20241202115140.33492-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qy0iQs7trXhPSa/VJ9TwZ80XuXPrbDjWDrphpG4soUTPmb7RRlb
 6Rs1Rmr+6YQPIptsORrb/fbszZv1PShC+M/L53DHnmX9nlksFN3AjCYI3jEwJB8OKWQV57+
 ODm/4cLAizujnRt5dk6snflV5JEVDfDDb7YzhOlzPY8xpmWfW6SpXicJjAIC3PwNZL7EPGB
 s0W0ZEpr7trBXv8CCON6g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kRPqPoA5QW4=;+h2fKxCFNIpKxPPv/AVwU8nW6jo
 tWxkZopz0nLWeJvonCVCaZtVJmjwa5SVmxRbPuoqcBYtokVaItC6IlzsO5EwIVPI1lXdGFEN6
 jRwEmXUxwW8worEyxMLhZvARJzyInbVvPOSt+TR83vz0Znq4AbBf/Br0Yw6dbM/i2W+QFVLQ1
 zJi9yGDDwSqTbnhRvb1GhKLI760oOu0z89qeclGo1kbK4E/B4IWUPa+DLmpYs89aQWvc2pyNh
 otGS3h6qqRrq7CnO6u1A6mxsG5tDjMLX4brqyJJ7bJY5agUUyfPFySI3TK7RBUXkwmokPjKDJ
 nWH9IiwC34JCz8w0PO77ZTtrD/5wBCgU8uo5XYCB2qn2SiTFwF6e2Kk0kOTmEjvfIdW58VDt4
 tHIqs22ZrPxjjsUHwQucNJFgB6LyYLmstDAD5GDv9q/JGW+gTEKqfHSqOXWeK6O2jlLN2uMYa
 q4NrWee8W3LTPCCLXGL0pG9rcPdYveoZxJGsDkFF8IF5mB3uke0wL3Qw8yPDQ7XPdo3uQLYxH
 D2quHcufNhpwF7zc2ylB4v4/Y1ACjO6jn+mRTUoyBdMeQ0zL5oVQNsDB+mqj7SpdEq4Yy+oA9
 kjRPpNmS+BMvyr1DlG3BFnrcF2kaNcOGiBL6ypMsAmuLhlEQralfyvF0kPGEd7ffpeC8W8iSS
 CXam/IEa6/hyb8ux+Qtd0swp3XobF+fZ/yXEfGLJL5yFpi5XE4TkeGABqWbpb9Zx/cj4C2mSi
 lOu0QvTL6PF8xebLdtCgNuV3ukDpzfCNgQ8sM3CCGiZcZUY6kUopjmcj+21A8WfJjtZrcptC2
 /Tgt9RGKBRe0Jbc1zylx4Dlorifu78Z7mpD380fcY6xGueTx/HknbFosvOzgqWabrujC4iVgJ
 vJBTw0ucQGPZzzRf+zpCxGSPwoNueYS1Jj2O1XB5XGLrChRD5jmbHjIYHoBrZFDeLYu9FOHAu
 tEL6J6U/Ae0G8t+/j0X8b3WeZqwWtOe+mmE9NjxYe9PhiyXQqheghhcHcR0tpJZKKO2S9QaFm
 7FJ0+fNorXF+nOYiSIVfnjjhchWWwQGyHL0yewPnSS4ZfRG5WKk03k3/uhF1V2fgOvP1kjPhp
 9YvhuwJZaEeZdw0Tx8TD0yFQdXHN88

Add a minimalistic suspend/resume PM support.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/mmc/host/bcm2835.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Changes in V6:
- split out of series because there is no dependency
- remove unnecessary complete check

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 7847f0c8b465..e5f151d092cd 100644
=2D-- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1343,6 +1343,25 @@ static int bcm2835_add_host(struct bcm2835_host *ho=
st)
 	return 0;
 }

+static int bcm2835_suspend(struct device *dev)
+{
+	struct bcm2835_host *host =3D dev_get_drvdata(dev);
+
+	clk_disable_unprepare(host->clk);
+
+	return 0;
+}
+
+static int bcm2835_resume(struct device *dev)
+{
+	struct bcm2835_host *host =3D dev_get_drvdata(dev);
+
+	return clk_prepare_enable(host->clk);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(bcm2835_pm_ops, bcm2835_suspend,
+				bcm2835_resume);
+
 static int bcm2835_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
@@ -1471,6 +1490,7 @@ static struct platform_driver bcm2835_driver =3D {
 		.name		=3D "sdhost-bcm2835",
 		.probe_type	=3D PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	=3D bcm2835_match,
+		.pm =3D pm_ptr(&bcm2835_pm_ops),
 	},
 };
 module_platform_driver(bcm2835_driver);
=2D-
2.34.1


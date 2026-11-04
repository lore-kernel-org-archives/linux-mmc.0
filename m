Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=148.163.158.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793758311;
	b=uZUxB1rdh12cXiFUEAkjQ8FMc2M1M9P6v++zezw07OwS/vTBWt0HtnENO1I49/64hfCc
	 v+FDavPA8Ow3+6wxR/suzDEc6dpBkej8BUmIlsViIazzy5GK+wwErmkjcvv5OsT38Lcsa
	 3+wrBz/PzMy1He18OIzg0GPLtM241LJM7z8CG+fiWzkir3Hx3EiUq19DPZT8yPOEuyt5x
	 RIO0fB4UQLgScDUEkxx5jaGY+fLBswZNkdhuKPVQNjgj/jI8Wmm3F8tOubheRn7HJnBSY
	 TWGP9X3FbXiHkYWw9bkk5tQpcn6+tW6zbesGhhwbTQECT9OVOUm5TOb48uvNIVt83eg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758311;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:Received:DKIM-Signature:Received:Received:
	 X-SNPS-Relay:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jha6mtadtnfuHe1nr25DRcktkJaYynwSK0zqMNl6IG0=;
	b=15AR4IrU8OGsxAaSKCb+LtfNLVMMDG6u3EwjbSjspFQjZG1X3E2ea0baCCCRPnH5k/iN
	 vioZvWD+emSWMuiPDnSYf4u/9+qBz5mFsqkRt5ZUN6r6XUp29PwN+pMcj0zPcuqo63AFe
	 pF4w2tCzdDQ+j1Xx4H0shBHZir9mGufIdTAWvXOG1UKpX6cL8Kcq/I3ldYZmQDvyiAlAn
	 CpmDGBam3iuA3hb4ONGUZLV54v86vpzsK4Ko02pf4WoUR6TbCkX+xpcG6ldHl5TdhbV9Z
	 ux887cYZ+F36WpLqdROjractOMRCtrNKJ65UqBJkL7Wjf3J43Bqvec3QKWXT0oXF37w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=h7e+aqNy;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=PPN3OiD+;
	dkim=fail reason="signature verification failed" header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=kNMPEKN3;
	arc=fail smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C725606A31B;
	Wed,  4 Nov 2026 02:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C725606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=h7e+aqNy;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=PPN3OiD+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=kNMPEKN3
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A40SMuF1377174;
	Tue, 3 Nov 2026 18:10:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=jha6mtadtnfuHe1nr25DRcktkJaYynwSK0zqMNl6IG0=; b=
	h7e+aqNy4oxFYMZIt243b7YnHrXYDTQtWSwrlB/E+smNBny4eoG+eu9cEGTzeapL
	v4KkCO2UCNopRx48uwOoSWwzP166f8EtgBl7qyS1d/nEoiqVdG5TTQe8Zvobq9PP
	9BJZwJYxu+nlpyqgLUlyZyNlvizge+1M7woVr/cDZ3vQtpITL841dfKFgfj9yFM9
	bTOXpbOA4aNJYurfDSHbqA6CrBNbf1mGe+Qdt/ZJEVtl3oDx+WbG9dV3taePIa2L
	NjuxLJQ8oLMKWQ3YoV+wO7LGv+IzVzwfrdOBWd82uh67E/ilRAUTOJyAP30oVxpz
	l5tdbvxXcRdepjtaufEaPQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4hqctw04cf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 18:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1793758207; bh=jha6mtadtnfuHe1nr25DRcktkJaYynwSK0zqMNl6IG0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=PPN3OiD+/RQD8VS9eWcnCUnBaPY1PlwBUzeA7SDx5n/tPkMMHE3EOBJyf17i3TOOy
	 QXFlZ+LsCZaLzO5vj+bKDrPOgS3JKcyvC3mg1tzVlFkZ5ScRsvgA7/5TtLkFUM7bmu
	 B1WtRT0hfFGtCPLLM6Mx6DJ71s+lm7hXqihRZd3wffx/MJnJRRpy2wvkqqQMFoPru6
	 7z/Y+xWmtpzfQFt9lkedbFVqEfMNdh2KbKMUp/FW6HhL/FfCFaVFHR2rDmyVes815Z
	 VJl3MRsRuvpNMZ/1cB1V92yPU0TBjV7EKx8ZHm803a2r/M0kwuEqAy+UXp/dkCL5Yb
	 F6Tukjq4d6bHQ==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A982440114;
	Wed,  4 Nov 2026 02:10:04 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id ED3BBA0298;
	Wed,  4 Nov 2026 02:10:02 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=kNMPEKN3;
	dkim-atps=neutral
Received: from CH4PR07CU001.outbound.protection.outlook.com (mail-ch4pr07cu00102.outbound.protection.outlook.com [40.93.20.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id A05DF40212;
	Wed,  4 Nov 2026 02:09:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4nKRGbMVqn6GwvNiBFtqsqRiz8TzuvI3LTmDJRa5xQ6nxg/E/FZLOMnP098CNORH0pDstfCMSjv+hhjwPivtpqMmsvp16qOWJqTu52351KGNYFlhr0Pz9oKa1vfLs/qbVOigBIwaMJ3fgTx8u/P7alUKXjZUkhZqKBXU8l8ZybysziRqCvWCHAFvVtoOVUUltY2IZcxEMXgoKhzAE/uownfvBqH9BYqQQ+OE3XTUZCXMm/4jMdL2qn50LxOvqy1GZ34AkChr3Yj5ng4srRTvTNHSdf8UjZeLUOKs6PXx03tjFZF6eLqTbTv88cczr0UIWi8XQPA5qdjARUGKcS/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jha6mtadtnfuHe1nr25DRcktkJaYynwSK0zqMNl6IG0=;
 b=qsGlat3UgSMlys1X4+TWF+vrPUFonaC3wjAt2RfeJQgNGps5RafJiEzcLKSwWUO67WKPsmluVeLj6P63J9ehfem6EEu7pepUh98uvgqgsdrFI9DJHPGbN3LzHmA4bDY9Fya2dn+vayGGzhkoX0asMrrGZHx5q3yURzLC0tUXS30YC1gVCAMCyl6xDOGc6VIV6fbx9xqYr3scGquFDUhmsvIkdWe7E6SXsI5IXU6xyhCWODgzwxpjMOP+lSe2SvmYtjC/p8zcRJUO6gFyJS7NHOwVh62gyOl7aE/7bHKoc8UnInSer3lIHVU4JoZ4BWJvyoKsJ6+2hPxBjBfk/ViNQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jha6mtadtnfuHe1nr25DRcktkJaYynwSK0zqMNl6IG0=;
 b=kNMPEKN3oFfxxnNzmi5myHfMTHJfoTF4ROs3pDZsBcmIHmrYGblPAQQv9Z4VGLkZfeZU20cJNGey6aDCQ5Ge/EJj0mzJ+69VYul8iCnPMNcZ5SGMryYAsur2nYDhkuI0m/JZkaPWM6kLhYEVPrLv42aHHiw7oXJvpnenay2M9KU=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 02:09:54 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 02:09:53 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "1579567540@qq.com" <1579567540@qq.com>
CC: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Elaine Zhang <zhangqing@rock-chips.com>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Ulf Hansson <ulfh@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wu <david.wu@rock-chips.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mfd@lists.linux.dev" <mfd@lists.linux.dev>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 23/27] usb: dwc3: Configure RK3572 PIPE port before
 discovery
Thread-Topic: [PATCH 23/27] usb: dwc3: Configure RK3572 PIPE port before
 discovery
Thread-Index: AQHdYXcJSpO7vFA2TkaQ6ybLG92ONrcdQCCA
Date: Wed, 4 Nov 2026 02:09:53 +0000
Message-ID: <auqRrz1kM-sfJEQ-@vbox>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-23-0b0fd85a31ee@qq.com>
In-Reply-To: <20261022-add-board-ok3572-c-v1-23-0b0fd85a31ee@qq.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|BL1PR12MB5729:EE_
x-ms-office365-filtering-correlation-id: 6c73f557-111c-473b-4301-08df3a18b743
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|38070700021|56012099006|260925021911599003|260925022911599003|260925021311599003|11063799006|4143699003|261022105027099003|261009223027099003|261102123227099003|261026121527099003|261021121427099003|261028144727099003|261026140227099003|10067099003|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 SnGe0emwp/vH2ao4w5xg0LXks4JdZDGIxtjLPZzuNYfzT0Q3uQ/eLszndnZiA34TjRwueZMwj802BYE4UcmKjkVbVEGrZMcijXACqNl2uFrSv+5eECowWHhgcU+rssE5L/PMIjhujNzXWzSa3bbT5pFIKsbcN3eLL/qOTsEL7VZP5E5IEKbRp2TcTPx/kZ1KoP8E6mCZb4CHlc6LE2mtnLOPVVX/1/809IYdst1M++h/Zvrji4F+yOge6VOsPDqhiHd59P4oyn3Bh2gQM6oW84kVIJ1AKjX6ohSwuODbHvXQwp2FCdSmTk22bK3l6fKadaddEZQhJboQgVLi0LWB18MEHHMSL2yvDuJ6MD832nCF9U2mdYuU1/LumUswBBAI+DS4POBRlB5XQD8eJ4yEpEd1IdCb42SQPcoU059GFNYhyaGi4UpmNm0H3+3GBd8DLOpjcGW8Pe9+lPnTE7MVjg/zK+aqTKzPTkvyPISphzSdirHTVtLv6WTEKRl64R2+wlOyJIjtBvugUJRx1ncKDua9CZQpHCc/rjJvJaCQpFKAV0MKNDtmPFf+yuqtdRye0xYKoXgcwLp3N86BuiM4sOIELsC1b544340MgnONKCVE1JAYtBK/h8Q+Y4l45ccebIdBdHmCmu8qkSpyRX3nEj+vMuFv72TIEvXWVWLTKN/xZegyAxaEu6NuR18eMR1/Dr6XekMS3euWLHGm0ZEeCF02B351CcFwiccMvnmXohc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(38070700021)(56012099006)(260925021911599003)(260925022911599003)(260925021311599003)(11063799006)(4143699003)(261022105027099003)(261009223027099003)(261102123227099003)(261026121527099003)(261021121427099003)(261028144727099003)(261026140227099003)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZTR5UFg1NFdSVlR5UzRzUkl5eml5a2RTQjhQRmxjWUtETDg5bit6UUJMNk1l?=
 =?utf-8?B?dHhtblpQRTRtRGRSRXAxWlQydm1rRFJucVFxNUtUeVlUK2Q4dGZVLzI4OHgw?=
 =?utf-8?B?NEErdzBQaXBXN3JHZlBvY0RadHpsUVhwNjJnY0RKWTdjOVNkZUx1M1c3TXpU?=
 =?utf-8?B?V0hQRFdIMDQrZ2szNC81c0gvZCtYWmt0WU9sNWhvMVNGK3djSlo3Z05JZnBt?=
 =?utf-8?B?bms1VzNEclpaMEZ6ZlZycGRTVlQ0Z3E3WWltNEFGOWlEcEZLaFU5LzJ6a2M2?=
 =?utf-8?B?cmlxaCtyV3M3dnFLK3lsNHEzNmxRV0NQcXdKbHA5czBOajJia3oybUhZSGFn?=
 =?utf-8?B?OWYzVzk4ZngxaEhseEJkbmpPZlNXd2JqRjF1ZmVNenM1eXU0VFVWQXRodG54?=
 =?utf-8?B?K29NUjlIQmplWStnRFpVSUVrekpSN00wek1rUU5aU3ViUzIrUE0rYnFZR1Rq?=
 =?utf-8?B?TmtKajZIZTlaQkNQMjl0b0tQUDAwem1WZnpySTFNcUlHd0I4azhJbURtZktF?=
 =?utf-8?B?WG9mSEpaT3hiYUx4dTVTRUs0VnNnT1FvTHZXOEtCWmpMV3ZudDdKMHVFSlVH?=
 =?utf-8?B?Sys2R1JETXVOd1FpTzcrYjhKU2ZWREl4WlFQUWhOUFdnSUkzWlYrUnhxRDlp?=
 =?utf-8?B?UWhzYjNZRmc1TjJsNHMweG1LREQwMVBscllldXNlZVVJbElldGlIL3g3cXVx?=
 =?utf-8?B?YnZUT3cxV0thNDIrM2p4TU43NDFUQkE1eTdmdE05T2UrbTJaTmYzNHpZZzhl?=
 =?utf-8?B?ZFBmKzBPMFRJR3lLenZiSkNZRGY0WHRWU0NXRWR0cTFMV2w2WUdDeWg2bkpQ?=
 =?utf-8?B?M2hQRDhuRnppVlRPVjFGTW5EVExwakpjT0RIcDVGdkRiZUxQenN3R0Q5RW1h?=
 =?utf-8?B?UUh1MnBEdW9RbDBCVUR3MW5Zdjl4TWFEeHN3a1loOXdiUTRuUFByK2l4MFk5?=
 =?utf-8?B?TGhrcW8wUERQTTR0V3U5dzNBb0JkSzRHamlLKzNqaXMrelc1MUFwQ1hTaW1C?=
 =?utf-8?B?eEswamFVZXoveVFDUEdwVXhMU1ZQSVE3b2xFUDZ2am1EbEcxSG4wenZqSXlF?=
 =?utf-8?B?dEpESEtDbTRSQzZNWGFuUnpteTFiakpsUlZ0Y3dTRi9IMWZrelBNcFpRYUc2?=
 =?utf-8?B?dFMranZFcUxHU2VUNlFIY2hNcEFRRVR6UlZnUkdBdjJaL1U1amlzdEtRaEM1?=
 =?utf-8?B?Y09tZDNkaGQ2ejc5U2Fnb1BjQmcxYm90VHpuT0xNckNNTWNIa0FvbkNnbHpq?=
 =?utf-8?B?R2JIT0I3dGdQay8zTzlwc29vSEdTajhhZStLa3hQVkdhOUxERUJzWDkyUlFS?=
 =?utf-8?B?c0VSN1pvUkZwMlJUakdGSkhQYXU2U1d6Mk9HOG52UzRvQWV6a3ltV0hSYUsw?=
 =?utf-8?B?S2VCSHlxbUZzTTczMkNVbWY0R3l0RWVoZ293UVFkbWZhaXZmS2xVZEdGQXR6?=
 =?utf-8?B?K0phcXM0TGdOTDh1TWJ0aTZyVmtZSS9ub1N5Q003ci9USnNXS0w5dUViaEhn?=
 =?utf-8?B?eHhEYmRQd1BRN3VDaWdiQm1oeVY4VFVWejRVU21CMHp3Mm1acWpHNHBvZzR1?=
 =?utf-8?B?UG1tVnRqNUFhcXJOeDZ6VFI3WjRVMlNrMlVuKzdaK0NOa3RxWm9pV0xSZktk?=
 =?utf-8?B?S3hDQkpYT250S0RaSEloNEJpemRTbkgxdGZNd2ZKa3VlUWJmWXROdVY4ZDJE?=
 =?utf-8?B?V1VFN01CUjNSMzFaMTc5dG5sRnZFbGRHRUQ4dmJKU2t1ZGIzVWVpRFE1V3g5?=
 =?utf-8?B?QnJ2OVVuVDEwMVpVVXZlaGY4UElyOHgyeWNiU1VGNFAwSHA3NHpBdTRoZjhQ?=
 =?utf-8?B?aHdBZzZCY1o0ckNhUE1uNjBjK3pCQzM2WURhTDJJcG4zT1ZQTUFNM092aHBT?=
 =?utf-8?B?VFdGeW50bkNBcW5WY2wzMUh1TGJQdlYzTEZEYkg1NFQvUWp3eEhnK1hlSkR2?=
 =?utf-8?B?bkFLRTliOEIrU3UwVEhZaHA2U3VMbmQ2d0lEVzBCVE9kMWVreGxUYzZMWTRj?=
 =?utf-8?B?cnVwbjZVbjJLVmg3TWhYdWR6cWU0Z0w3OFJFenIybTZvY2RST25WL1hnZjQ4?=
 =?utf-8?B?QjZaQWVjY2V6MUNlTWlPZVZOSk50dlhKUDhwaHRNV0ZjUEVERXdJU01tVTkx?=
 =?utf-8?B?ZG80WktrbTJBbTVFTG9pemV4RHRaUm1tbTRaWHlsUS9WZmpmd3JVUkMxK1pB?=
 =?utf-8?B?TkJpYW9nbFpxQndqUHdQR0pjcmovdGhYSHU5Nk5BRHl0SDJzb2FkM0xQSzBk?=
 =?utf-8?B?cXplRGU0N2xPTnYvZUl5ME5rYzZ2WXFkNXFWN1kwMCtaRnliMm4zdHRtZ1hr?=
 =?utf-8?B?WGN5WnUwVzVwWFZJanQ1dGdRSkZ4aFd5djRZeUpqMFc2eEMrQ2NHZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <589372F405E6B54A91E0DCD404123614@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	trxif2/ugGKdRHJVcAJBq/H4zSvDn8Wv0r82BIwSrc5DlErjJiRSIBtUuw7G/7o0rwqWPazPlSgf9jag4lphUxfRSIjsKLDOoH47TbRMslco+RhoEFsT6m4DbZgbzZfzuABDE1BMCLLZPSFdXl4X67Kl1qgaK67+Cr+OGik6PWrnzPWhge9CwfQix0ljmPQ2bPvLoZFP5/F6FwMXbTn8NhLMkP6NMZiuWpdTR1K2xUoeCoWtRCkOUrehtfpvv636sgHqiJu3rbxWftmxc127tivKiOVfAazTqK+3WF/B7aWo4eP/vu4WoU5fCWR1Pz3ir535E13tM/ABB4KNxUYQMw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FCBE6QxTIDgK0v32/7EwXf2NqVyNCUmk8LvqP/malFmRO/3Ydjx7aAcZ99GTJw9/Famu2RJGG2rTg3FYg26YCr3lJVYtFMP7ieHYQpxZalhVONbyYhNaYiVD8afw+ZfyBs81DLW95tTWz9LnUN8ANpktrtsZ/en3K4aBpROYuOpaTe7U7qtxrZW1jE/LtPMtamxzvn6HTaXESNAKz/2mXpz1fi468vORC1jsWniOhErhlgzEbijA1Y5euR85Ra4/OP7JjLPTcsAe9I87g7LGPdyjAaD0sc4wDQTM9ztxWIpN756MvQ68AQi4BKTD44VMLBY+UZ9w5ZUkjnNn/fcvW83CQNGh9Qqd4pkErPQKX7zrt8qg9qtsJk47Qc8J8+ae1eGgZULAeAqfxXKGaDwzmST/n+XfZmjoKqoDfhxOfDUYzs6FJjQkaepV5qtZhc5kqiMSTT+87j/ABBG/xpLN+4DblLsDZ6nxEuk4Wvk1IG53EiwXTxmA2UgtAK7ZyiYaEmVVOf5Z5lJtJ7v47ZM+Or4Fscp0tazAGWsKbYCJw5zBb9CedB5fJPWphuwWDNMrJonAQts3lLclMHA069xHWGgBHuw8BhBgRIOXWg874ziN8evKxHEVw4U6R/xak+97gG0daoCyNwakI4mfydprPA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c73f557-111c-473b-4301-08df3a18b743
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 02:09:53.8038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BrCrUrCcSTsqQEFQzADnKfxGK/eTmBR8WXOw4t8kgeBDD+jhSpb+CU2P41pCkN023Vx0R4Yqv3MxmMneTsOMSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729
X-Proofpoint-GUID: YjTBVnhLVmYoto4ISwF0VHqavZC3h6_5
X-Proofpoint-ORIG-GUID: YjTBVnhLVmYoto4ISwF0VHqavZC3h6_5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAwOCBTYWx0ZWRfX1TLKDMuaLWyW
 5iagMQ9JL+/g+KpweCqg5M7ykmqob7fKsMLvhdtIZM39hGgGn7uRNW8FLS5Tkwovfwo4lqu0skI
 ZmIiqQ4BJ+dXdUgR6UNc2oYmblr8/ueYP6vMdjQAsXxwSNCo1YN8lVAGDo3XGXkEXrfoe3qRCPC
 XzkNraFRKk77EsOByohTHKYlvVTy+xpPen7R3o3n6Hv7HSACwMUoudlajRmYVLc0mA0k0z2xMZs
 4RudsI8uL5zS19holeBSfUPBia9F5dsvTq9Ff4TJbw5m7u1e9JLQDzLFd+z86cIDnOx6Li62BG7
 QB7GMzQUJ2YuXHUlDEttPPJBcIxu5H7g+O8GKIQgE0/zGpB/Sl1R8inXDj4xrCFjbMFiw94RWaQ
 SEYah7jwjrRvzp2sZCylkeYXAw7SP2wzH5HaCdGL7y9s80xRk5ggqd1o3k75IYIfXL053GT7DA0
 I+Q2gKRgRw6wtYFrs9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAwOCBTYWx0ZWRfX0860FXBWolIW
 ZIWmafaPvmSflh8NsgtjNFI93vsneIyf2TYR5eWTc3SJ1X/PYk3Y9x1CCUxD9QpRARhkB30/wL1
 3VRxmOEXtH623QvrhP2KkDPDYnQ4ERk=
X-Authority-Analysis: v=2.4 cv=ce5HPXDM c=1 sm=1 tr=0 ts=6aea9400 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=dZbOZ2KzAAAA:8 a=zrXCNW9r6ifbuSaJk74A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 phishscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610300000 definitions=main-2611040008

T24gVGh1LCBPY3QgMjIsIDIwMjYsIEN1bmhhbyBMdSB2aWEgQjQgUmVsYXkgd3JvdGU6DQo+IEZy
b206IEN1bmhhbyBMdSA8MTU3OTU2NzU0MEBxcS5jb20+DQo+IA0KPiBGaXJtd2FyZSBtYXkgbGVh
dmUgdGhlIFVTQjMgUElQRSBwb3J0IGRpc2FibGVkLCBjYXVzaW5nIERXQzMgdG8gZGlzY292ZXIN
Cj4gb25seSBVU0IyLiBDb25maWd1cmUgdGhlIHBvcnQgYmVmb3JlIHJlYWRpbmcgY29udHJvbGxl
ciBjYXBhYmlsaXRpZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDdW5oYW8gTHUgPDE1Nzk1Njc1
NDBAcXEuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZHdjMy1nZW5lcmljLXBsYXQu
YyB8IDMxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAzMSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9k
d2MzLWdlbmVyaWMtcGxhdC5jIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLWdlbmVyaWMtcGxhdC5j
DQo+IGluZGV4IGNhNjlhYzBlYjA3Y2UuLjExZTcxZmM3NmJlMWEgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzMvZHdjMy1nZW5lcmljLXBsYXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9k
d2MzL2R3YzMtZ2VuZXJpYy1wbGF0LmMNCj4gQEAgLTIyLDYgKzIyLDEwIEBADQo+ICAjZGVmaW5l
IEVJQzc3MDBfSFNQX0FYSV9MUF9YTV9DU1lTUkVRCUJJVCgwKQ0KPiAgI2RlZmluZSBFSUM3NzAw
X0hTUF9BWElfTFBfWFNfQ1NZU1JFUQlCSVQoMTYpDQo+ICANCj4gKyNkZWZpbmUgUkszNTcyX1BJ
UEVfVVNCMwkJMHgxMTAwDQo+ICsjZGVmaW5lIFJLMzU3Ml9QSVBFX1VTQjJfT05MWQkJMHgwMTg5
DQo+ICsjZGVmaW5lIFJLMzU3Ml9QSVBFX1dSSVRFX01BU0sJCUdFTk1BU0soMzEsIDE2KQ0KPiAr
DQo+ICBzdHJ1Y3QgZHdjM19nZW5lcmljIHsNCj4gIAlzdHJ1Y3QgZGV2aWNlCQkqZGV2Ow0KPiAg
CXN0cnVjdCBkd2MzCQlkd2M7DQo+IEBAIC04NSw2ICs4OSwyNyBAQCBzdGF0aWMgaW50IGR3YzNf
c3BhY2VtaXRfazFfaW5pdChzdHJ1Y3QgZHdjM19nZW5lcmljICpkd2MzZykNCj4gIAlyZXR1cm4g
MDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGludCBkd2MzX3JrMzU3Ml9pbml0KHN0cnVjdCBkd2Mz
X2dlbmVyaWMgKmR3YzNnKQ0KPiArew0KPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9IGR3YzNnLT5k
ZXY7DQo+ICsJZW51bSB1c2JfZGV2aWNlX3NwZWVkIHNwZWVkID0gdXNiX2dldF9tYXhpbXVtX3Nw
ZWVkKGRldik7DQo+ICsJc3RydWN0IHJlZ21hcCAqZ3JmOw0KPiArCXUzMiBvZmZzZXQsIHZhbHVl
ID0gUkszNTcyX1BJUEVfVVNCMl9PTkxZOw0KPiArDQo+ICsJZ3JmID0gc3lzY29uX3JlZ21hcF9s
b29rdXBfYnlfcGhhbmRsZV9hcmdzKGRldi0+b2Zfbm9kZSwgInJvY2tjaGlwLGdyZiIsDQo+ICsJ
CQkJCQkgICAxLCAmb2Zmc2V0KTsNCj4gKwlpZiAoSVNfRVJSKGdyZikpDQo+ICsJCXJldHVybiBk
ZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihncmYpLCAiZmFpbGVkIHRvIGdldCBQSFAgR1JGXG4i
KTsNCj4gKw0KPiArCWlmIChkZXZpY2VfcHJvcGVydHlfbWF0Y2hfc3RyaW5nKGRldiwgInBoeS1u
YW1lcyIsICJ1c2IzLXBoeSIpID49IDAgJiYNCj4gKwkgICAgc3BlZWQgIT0gVVNCX1NQRUVEX0xP
VyAmJiBzcGVlZCAhPSBVU0JfU1BFRURfRlVMTCAmJg0KPiArCSAgICBzcGVlZCAhPSBVU0JfU1BF
RURfSElHSCkNCg0KVGhpcyBjYW4ganVzdCBiZToNCglpZiAoZGV2aWNlX3Byb3BlcnR5X21hdGNo
X3N0cmluZyhkZXYsICJwaHktbmFtZXMiLCAidXNiMy1waHkiKSA+PSAwICYmDQoJICAgIChzcGVl
ZCA9PSBVU0JfU1BFRURfVU5LTk9XTiB8fCBzcGVlZCA+PSBVU0JfU1BFRURfU1VQRVIpKQ0KDQo+
ICsJCXZhbHVlID0gUkszNTcyX1BJUEVfVVNCMzsNCj4gKw0KPiArCS8qIENvbmZpZ3VyZSB0aGUg
UElQRSBwb3J0IGJlZm9yZSB0aGUgY29yZSByZWFkcyBpdHMgcG9ydCBjb3VudC4gKi8NCj4gKwly
ZXR1cm4gcmVnbWFwX3dyaXRlKGdyZiwgb2Zmc2V0LCBSSzM1NzJfUElQRV9XUklURV9NQVNLIHwg
dmFsdWUpOw0KPiArfQ0KPiArDQoNClRoaXMgbG9va3MgbGlrZSBzb21ldGhpbmcgdGhhdCBjYW4g
YmUgZG9uZSBpbiB0aGUgcGh5IGRyaXZlci4gVGhlIG90aGVyDQpSb2NrY2hpcCBwbGF0Zm9ybXMg
c3VjaCBhcyBSSzM1ODggZG8gdGhpcyBpbiB0aGUgcGh5IHJpZ2h0PyBXaHkgaXQgbXVzdA0KYmUg
aGVyZT8NCg0KQlIsDQpUaGluaA==

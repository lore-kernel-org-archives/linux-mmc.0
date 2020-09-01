Return-Path: <SRS0=T3o1=CK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50175C433E2
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 09:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343A5206A5
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 09:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIAJ6j convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:58:39 -0400
Received: from mx0a-00176a03.pphosted.com ([67.231.149.52]:11646 "EHLO
        mx0a-00176a03.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbgIAJ6h (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Sep 2020 05:58:37 -0400
X-Greylist: delayed 8456 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Sep 2020 05:58:37 EDT
Received: from pps.filterd (m0047962.ppops.net [127.0.0.1])
        by m0047962.ppops.net-00176a03. (8.16.0.42/8.16.0.42) with SMTP id 0817bCx8019986
        for <linux-mmc@vger.kernel.org>; Tue, 1 Sep 2020 03:37:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4y9Kp5kI6dLgWFpYREd7+KGNWVJByV9redNf0Vb/gKFGhszhxNcUQ61PGluSENPfj+WkyD3ofzDrzQJgOGeLuIDZIgnJcv+6N3USUdXfa2siSKDM11crszNKUbNqfKYJsQ/YmQFCjCC9bLQUPLjw5hHy4o+I4qquBkCpHsaOsVALI/u9ZRN9noUMoMr0vq5Qaf4JI2jcBNLhHXgLJVWMdNNQIfTl0goaZ4ERemOUXi34BfGWwo2NQNbvsCJaN7HgHOBaggGRFZOXu/YBfV3n4uC5/VR1P8UK3XldHfipjV+pdXyokBYW0B3No6uRZFW8EFyCT+z8hXygDNi5P7pOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZzQpeUSLKGHuFN9RSA+Dpf2lq1ssdAH9MNtJdCnVM4=;
 b=Mg+sMJ8nUWVdiMBf0ewtdN8ZU1V9KdEuXs6XKeec9SJ4v/KVaYFlRp8itX6d+jyjGf/tHSmfRby5W3lK9+D0IUqi5MSgy8G12KAymvZyHucjnguA37gsX79d7eOFJCkg2qlKsp7WdVMcLO9hica5N8mTR6HiCZ2FGxuKAto9MEygpA4Z8ZBTx8aNOjPu77Th8cwF8YzMSx6CeMo0gBxch7q710t/b2RWE8OrHE3teDh45MiMgo8YJpErTSBgQPnNuzV+tnGvTExIotbV6N3a9UTJ++h3vzUvRHJXBb6y7THsW0nWYmyVsMMgSsiJLAAFSlmU9sxU9SNrp8it0fVSvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=med.ge.com; dmarc=pass action=none header.from=med.ge.com;
 dkim=pass header.d=med.ge.com; arc=none
From:   "Baumgartner, Claus (GE Healthcare)" <claus.baumgartner@med.ge.com>
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "haibo.chen@nxp.com" <haibo.chen@nxp.com>
Subject: mmc0: Timeout waiting for hardware cmd interrupt on i.MX535
Thread-Topic: mmc0: Timeout waiting for hardware cmd interrupt on i.MX535
Thread-Index: AdaAMoFCTyezERBOQE2GwxP9opqVdw==
Date:   Tue, 1 Sep 2020 07:37:31 +0000
Message-ID: <AM0P101MB03060DFCABC4A82C2D40F180D12E0@AM0P101MB0306.NAMP101.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=med.ge.com;
x-originating-ip: [205.173.90.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4604da3-b601-4e03-2265-08d84e49e2c5
x-ms-traffictypediagnostic: AM0P101MB0273:
x-microsoft-antispam-prvs: <AM0P101MB0273EA7D4C655175B0035448D12E0@AM0P101MB0273.NAMP101.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iuUCAsXZQfaqusWzieIVexeVAuyi2qI/7WOdQkRC+DNb+d12KdJ8lgL2wUgITB9KcIUzXRL0sy4lAvDnJvn3fypz5tgl7A3kAHitK+1wCxoKgXfXwMIiag/dP+zUREp1IVdsHyTRL/sf19hycCgZqJaMbsJTWQqheCO2kW64uIZDCqvM4cuBspVj08yypcZXrtLr0Gd0fOBW2DAnYQAwetjj5YW54JkoDv4lAfKR3KaPSaTfTfkFod1fM9NsNcG4Y5PqNQ0MXGoNGR6UbhynIV1IQFOsh+KTUeJh7sqvX/ZJADdY4cD+SPh08BZb4s/B/VsL/s2ImsECDciutn0c1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P101MB0306.NAMP101.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(4326008)(33656002)(2906002)(86362001)(186003)(66946007)(7696005)(76116006)(55016002)(26005)(66476007)(66556008)(64756008)(6506007)(5660300002)(8936002)(52536014)(66446008)(8676002)(71200400001)(6916009)(316002)(478600001)(83380400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: LfLSJG2DSxYV9JQYQ5qUB7PalqK/75OFDcKmJinlA1cee9ROL68XtTDPy8lFmcM07o/VUm97F6Bj/YdtZlFx4FX+otw46+ro9WQQ/zsaxLB2v+CvpjXRiBtWulbXSdgQX5JfTiSFWRVMae97x+wKPuxn2BABGwMg33RCWai931zqXBQhKXmzBJhWIn2thfj2Rwf9ppvNi+JEWRv1V/YFUpy7ZSpU87iRToBsNhDs48P/uoYsYqwhyB7jhRYhmC93VeYR3gG6ReNkLMOO1OHr4gxCV6fhOt9JxbTEuetddwVB829SmjcT8LEE3afzxvqT7onfKP8gAmMZY5KclJPeu4lO1MfWHPcekl/Epa00fIdpUXJREkeDCHaeDAGf1BgCyp3HeiBW3jfjHyH9K5P+BStaFFFUH8Xbcsg1ZRCm3s2WHIRMcyf4fTLNv1Kypbl2FdYXCl/wvCWkeeCkVFTLahwUN8LfjH8Ilrhl43MvDg8hm1bGlwaJWgml87MMji/+p2x+3zO5c1/jztKGwKNCFdqP/DQh+8JMn7uZSzNr/QtMbhGK8sOWexN0UgPyE697AL2f9OR1JC3Rbp/NRAoNf0Vs6CEpg32P6xbECkPVo7nilHNUQQpvGLahOcBS98TQR0RZUNvzUXJqgLzhzpwYEQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P101MB0306.NAMP101.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e4604da3-b601-4e03-2265-08d84e49e2c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 07:37:31.5515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 15ccb6d1-d335-4996-b6f9-7b6925f08121
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ncBsgS7f46/eVHocTznLMy/tl28WiUX/lBG/eL6r068Fq/wE4uslTK83Q/lprxTcFuTN/2to51+WPihlbWNa5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P101MB0273
X-OriginatorOrg: med.ge.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-01_04:2020-09-01,2020-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1031
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010065
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

We have a board with an i.MX535 using a Samsung eMMC as persistent storage connected to eSDHCv3. Every now and then we produce a build that causes emmc timeouts: 

Aug 28 07:32:12 csmon kernel: mmc0: Timeout waiting for hardware cmd interrupt.
Aug 28 07:32:12 csmon kernel: mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Sys addr:  0xe3f12000 | Version:  0x00001201
Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000001
Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Argument:  0x00010000 | Trn mode: 0x00000000
Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Present:   0x01f80008 | Host ctl: 0x00000031
Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Power:     0x00000002 | Blk gap:  0x00000000
Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000011f
Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Timeout:   0x0000008e | Int stat: 0x00000000
Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Int enab:  0x107f000b | Sig enab: 0x107f000b
Aug 28 07:32:12 csmon kernel: mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00001201
Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x08100810
Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Cmd:       0x00000d1a | Max curr: 0x00000000
Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Resp[0]:   0x00400900 | Resp[1]:  0x00000000
Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Host ctl2: 0x00000000
Aug 28 07:32:12 csmon kernel: mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xef041208
Aug 28 07:32:12 csmon kernel: mmc0: sdhci: ============================================

Timeouts do not occur with every build. After some debugging I have found that timeouts seem to depend on code alignment of the esdhc_readl_le function. I have bisected the behavior by using the System.map and moving/padding the code with NOP instructions (mov r0,r0).

My test case has 5 processes continuously creating a file, writing random long data, reading data and deleting the file. It seems that when the esdhc_writel_le is aligned on a certain address then the timeout will occur about 5 times/12h using my test case. If I add one more NOP, the timeout will not occur at all. If I continue adding some more NOPs the timeouts come back. Seems that it doesn't matter where in the code I add NOPs as long as the address is below the address of esdhc_writel_le. 

We also run the same software on  a dual core i.MX6 without any timeout issues.

I have reproduced this with kernel version 4.19.94 and 5.8.3 and we have compiled with both gcc8 and gcc9.
I'm still searching for the root cause and I would appreciate any thoughts about where to go next. 

Thanks,

-Claus-




 

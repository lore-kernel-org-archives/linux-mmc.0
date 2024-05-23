Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D55C14AD25
	for <linux-mmc@vger.kernel.org>; Thu, 23 May 2024 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470450; cv=fail; b=Ds6Zi+996nVv7OfjLXy2lpHzjQSrCsM6ttdx1VDf10sYgYPB7EdlNvrC2cYGRmM2ZsqlB49w8EBSmk562zJDHOhZZ2f8UWN8VEXLWTBxrqVYo7K1qzk2H2dK4ryo+RaJzVHIEWY1M2oWIfO/aopENdKSpj05I6RHsmZlV1dZ9BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470450; c=relaxed/simple;
	bh=1b9iI/ldxYrM2HfCpHKJrm403ST48gpJueAGqnGW1OE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PVscUazv4HcsmMsTcf5wQXOxAhZkV0V70v/tvLnEWdg2BTQPXVdrswIrB3gqusG6wF5p+eG0cM1NpQoND8KRKmPQ+VBay2BelgqzxT80wG9R/b2iP47xwrKqaNVt/XJ6DVdRa6VAebrgocf12ftn8sLTxNl2Ie1JVN4rdse0tTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philips.com; spf=pass smtp.mailfrom=philips.com; dkim=pass (1024-bit key) header.d=philips.com header.i=@philips.com header.b=uGW/2YKX; arc=fail smtp.client-ip=40.107.21.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=philips.com header.i=@philips.com header.b="uGW/2YKX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7poJh5j4EoPnHsjZGg2RjGFEEyj7BmCmJaV342T7izgwD4XlMjp2lpv98hkjNn5cs8OsQQFMPMg+hWGwRsil25G/Fil6cyFMMSCaLucn5TDTow/ZOVFCinn3uXudVeI14RoVczQgTGI5mqZp546EeRfUg2xtfWMlOdcuD2Oe113hqibfKBu3+U0GEKMAwAb40TQl4gbKfpt1xudi+/MEPvCP24dLedTnxB6Blk6tgWXIeWNWpKaVSHbnxp1xfOY4QnH1JURGGXTkM1Cr6bLC4Ae5O2EVC+uSDiEa92yiNDenAL7vyGMIELGEINJeNHtOMFufpsD56xwET6h0M9l0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEpJDGZiwMDUK4jFi2aMHTyIkvpp4eK7kRuO3bQe4bI=;
 b=PcvYwNFN+VeL8Iea5TW1iyZ2vSVSswEMqrugUb42UR7G81Ntb66Gj4JxxW6KOf+ZzYu67wifZEzxzZqLeyTn38YMEBHj1u+4EoFogeZTvmQ/S7Ce9aSDLmBhJ24LmXalk/rr9h4QIUHtmnHw+zHiXsaAJLClTrI9ryGyv8yTVQZamgnwyjoKHCj2tI8d+JVzxJWQY5RbQsb/cS5Am3+n68Pjkcmnt7F/y8YKPzmxNXt4yhpKYloYpZGX1ZV9KcwXr/6Qf3L0tagBhZm5hRSuLAMjhMJbeUypdrz4FcaTthUmf2Ij7UNc+6aEwQDt69T7JEA/LnUkBbI0UvPAui6XFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=philips.com; dmarc=pass action=none header.from=philips.com;
 dkim=pass header.d=philips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philips.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEpJDGZiwMDUK4jFi2aMHTyIkvpp4eK7kRuO3bQe4bI=;
 b=uGW/2YKX2h0BF+wVw1VtyMXp0TN8JdflltfiDoDeuJpAXMzjOeSvH8JE6GzfM6+8vJs+OIJGDvdkXMkqOEMc4AtpylWurewN/eCohC420GyJQH/R4UFSn2AE1FwVTs3RIY/2aiY4RZIwoVKvIRgrcsHGH9G1UPcersWYaLo4BrE=
Received: from AM9P122MB0281.EURP122.PROD.OUTLOOK.COM (2603:10a6:20b:22c::12)
 by PR3P122MB0276.EURP122.PROD.OUTLOOK.COM (2603:10a6:102:17::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Thu, 23 May
 2024 13:20:44 +0000
Received: from AM9P122MB0281.EURP122.PROD.OUTLOOK.COM
 ([fe80::2a31:e7dc:f131:1e12]) by AM9P122MB0281.EURP122.PROD.OUTLOOK.COM
 ([fe80::2a31:e7dc:f131:1e12%4]) with mapi id 15.20.7544.052; Thu, 23 May 2024
 13:20:44 +0000
From: "Loureiro, Joao" <Joao.Loureiro@philips.com>
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] Add functionality to read the bootpart register
Thread-Topic: [PATCH] Add functionality to read the bootpart register
Thread-Index: AQHarRANmhBF4ZCxpE6S3dg1Ljmf3bGkzUdf
Date: Thu, 23 May 2024 13:20:44 +0000
Message-ID:
 <AM9P122MB0281612AE803A7E6B5A5A153F2F42@AM9P122MB0281.EURP122.PROD.OUTLOOK.COM>
References:
 <AM9P122MB0281EA706B05ACFB3E0E2405F2F42@AM9P122MB0281.EURP122.PROD.OUTLOOK.COM>
In-Reply-To:
 <AM9P122MB0281EA706B05ACFB3E0E2405F2F42@AM9P122MB0281.EURP122.PROD.OUTLOOK.COM>
Accept-Language: en-NL, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=philips.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9P122MB0281:EE_|PR3P122MB0276:EE_
x-ms-office365-filtering-correlation-id: db0c54be-3305-4bd5-35f7-08dc7b2b26f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?5ni7plKtb4d0QB6Gc83cH8/3/5IR8Ku+8a/Ehjnpf6aZtYHWwDgFx9V1VU?=
 =?iso-8859-1?Q?sQVRNYACpgw1WdskFOMAaoIhiyABXNu8WL8hoPS1znGek419T4cF/5IH7I?=
 =?iso-8859-1?Q?y+qeTKhPP7WKsjWQbxC7jo28gnO589ROhk5y+gMJ5EUQ2/eBgKkgjGd8dW?=
 =?iso-8859-1?Q?yAwSLMgaQk9zuj8voK4Ix3inRbLgza4PLuStMu9gUo/8CICo7mKgyxfcet?=
 =?iso-8859-1?Q?cjI4h+5v6/boSWVgKRdibUg2mRX4CfcUJDvhcPkwninBY0YwQUKCxjBUl4?=
 =?iso-8859-1?Q?+u7ZDH2KMHk6XfW1owXFTSNt5fjlG2ybjBXyJteFFoekXS8SSYJTqF2rgt?=
 =?iso-8859-1?Q?vvyy1J/Y4mP3uLrCwKIVY0Bp+3G2Z1fRmbb5u0Zg0UKPF858GuaA0mpS9M?=
 =?iso-8859-1?Q?cLgxiaMosN4a2phw6yPUt47I5rObPPDz1IGCobo1uTXTrykOHA9WSlchmy?=
 =?iso-8859-1?Q?shRQikJ1kjCR9jgbY4dpmpcsdmBIh8vtoZUNQGnRPTS/9vKDFr4bC2YGM4?=
 =?iso-8859-1?Q?PVmWDP5ttPmqF2a27u6xQGj163A3MYlYDuOAXGfDJnxHa5PlkvmtOgV6d3?=
 =?iso-8859-1?Q?m3wdFxQ2OoQGKvU8hiJG7zjDwxE/MFu96mWCFspBQCP2wTyyx94BqB0anX?=
 =?iso-8859-1?Q?8f7HR1Ds3JkYl+dJyczc4qF2/U8oEVmBtRpqrUiVm5uHPGchtIECiA+S1d?=
 =?iso-8859-1?Q?6ED+5yFwxNWsLGymJotTvopnfYZxdMRC535yQgBPvJXutCAh/bpCFVz1m+?=
 =?iso-8859-1?Q?hqPE2+Bv60sylytkTFt8Lshrv0ItgAJ5duS8iurHx2ffVt/FMbCOrdY4Cz?=
 =?iso-8859-1?Q?Av2nYFrz35/RXE6eR+VI4kRMQLqrytq/Cyy/iAeyE8LJEe6sV6LKlzD01J?=
 =?iso-8859-1?Q?tRkxGB3V7/WRolYUFHuadRR9wFYcHBvzIrQkxwFmN04NPoEIe4yCkh2FpC?=
 =?iso-8859-1?Q?OZkwKqzwt2Ne2EQdUr78V8E1lFSzpZNU4NT87dGsHtHaPPNRVWit9eWZ2a?=
 =?iso-8859-1?Q?zgKPfJCeQsQ2mGqGUjpNeQSC6s3o4F8GnA+BTqlb2TEsExDOMjrkBAhXoX?=
 =?iso-8859-1?Q?FarfgpMGgrggjvcikMCvq1UtKYafrUVyPjXrRvuXt4JuO/fKHcbh9X1DNA?=
 =?iso-8859-1?Q?SptePnGHY49ZXGvmjvmbOlnU970iIYiFDLAHOUFy3KDWmI6MU1kRc1r3pZ?=
 =?iso-8859-1?Q?IPa07tv5XvBCXeuCUpfD5wwmsbjknhw30aux/jXmlQMlAoBwSDFuZXqWEe?=
 =?iso-8859-1?Q?8tjbAl+OqW0d6LLAdbaBrTi5dcK8/X+Qv3hnPfIbeKdOeiK9keYHOlQ3is?=
 =?iso-8859-1?Q?dcFlNvWbmDkT4oVQPOH+2ZogDy8ZYxEM7KUDT4aguWTnslVcwpIvV+hlv8?=
 =?iso-8859-1?Q?M05TlYq+ms6NJoiwAzyOkhGzDh1TS1GA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P122MB0281.EURP122.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?j8KRna5LY0JLw34ZIFAi9ZbwVmDDjDBzOotGpQm5xYE/w9PblyuOO3nj6l?=
 =?iso-8859-1?Q?6PVsFXxJYpaw0/7lQms9NELp+RBnqUC5EyNyw4XLZ7NyPDnCduLUSw3i2V?=
 =?iso-8859-1?Q?nzeQzXO9S47przQjjcw0JTv0xdi1nkGolJwusJY641p+BGh1ShJZr657+T?=
 =?iso-8859-1?Q?DGgH5K9NcenVzuutJDxhtyJfi6o487QZST1Y3vFz0wDvHYwuX/FBLBQHFo?=
 =?iso-8859-1?Q?feJGj7H2zepgQRhPYbLjDDxwufvbuOrsS+txkDVlh6pXJDYSFjYKiAi8j/?=
 =?iso-8859-1?Q?B/LgUJ34l9nICRUanHCRIw8sLOV1JRGTllbbCvBQewwxNqrVQEKqVMuVL8?=
 =?iso-8859-1?Q?kD6ZadW3Z+ldF4FEsG+Ygmd0oQ+8iXZHg3Pl6kupsfMM9qhDXqt+POuzlN?=
 =?iso-8859-1?Q?570GzOLG3OaNoPG+cznXlSgB9ImhN4ER0C00evYS1jASYWq2K655NZID26?=
 =?iso-8859-1?Q?negCL9rFq4+7GbSTnbxi4iuqryA+txMpEmC7vKH7Z+p6pge4ipKGtD3QC7?=
 =?iso-8859-1?Q?HXyue9qt7g9UZ6Nx26wBoYptd6d5ddhoHBPFgxKbQO6yM/Zgm4+1UyCLng?=
 =?iso-8859-1?Q?OjvQ8hAfHGO0o9TkTrzh2mxSStZgZbugO+xYwmpibQZB+iqwdwo2YrB5gC?=
 =?iso-8859-1?Q?GVhPYLJMpuyDdnovR2QIl3A0/RyvwROMWG8uCl9IqSPJCbq8qMbHwHFIZM?=
 =?iso-8859-1?Q?C6IM9dMh0YUB/RHCC9/VAIv7HWnfrSqYpLn1gMTLu5k1hhjcWmdT2c2UeL?=
 =?iso-8859-1?Q?qoqKKOwgSbq9gSr1lXUIHBH2ZydHKR+wqf338YhvjlEsoz5aQxOlU5/yZB?=
 =?iso-8859-1?Q?qEHyTpkzZHC4v+n02khwEx1mKx6UHOED2I2eOQt7I3FhbEFM+b8AreeHh5?=
 =?iso-8859-1?Q?D73Ap+CcrIn3XcORagw+uDvv76gjyXoPzx53pDTAFxBNfSz6i9uDB6Tnhh?=
 =?iso-8859-1?Q?+cATuXKRTuRzZJmg03ednY/b4Ja2YIWyUa0zXdV9+7JOv0uT0NTsnT6F1e?=
 =?iso-8859-1?Q?j2gnQbgR508k+wp+0QIR7YbPbAJa8014Km5OKrqVYb5q+CP7k6hzbWTs42?=
 =?iso-8859-1?Q?3KUEj/Ib6WF6A7tEapokqR8uyYE85qQUaAEDwDNsu9rg5QSfTB5hf45NoW?=
 =?iso-8859-1?Q?zf04SkCgCw9juVrRV8EMd1++VzEBhs9kGrt057x7xNvYsN+B56e1MCALfO?=
 =?iso-8859-1?Q?6WkdV9RyNB6Znp+GSB9uA4wicqfnZ5sQNtCoZLhl/7MAC4eEvV4CtNpAbU?=
 =?iso-8859-1?Q?T6bcpbHdLg1e2aNhhTPuXgN2+ntlkrOE6o6KuZtRvazcbVPOq5jmfqrisz?=
 =?iso-8859-1?Q?xm0fyRhErewaqjra5FxdRXOcN9LqSu1/ZieoCCAZ7FOdOuC36Mr3xDBNdq?=
 =?iso-8859-1?Q?wphOICU5V7rTNPrXVThvXbs0OAEhnD2uJjIjBuwePyW3AdZwEgEt9GZXRo?=
 =?iso-8859-1?Q?tzCm7+XiC6tLBqRUGBmR9V8F1A6pgR4TjiNq4dHK7LWs8zK6elU3kmeGyo?=
 =?iso-8859-1?Q?o4QxXMam3gaGtwKtQLcS8OMr19weHKzM/P+JZfjfT0qMK3UkYcp3Bic5xc?=
 =?iso-8859-1?Q?tQsX16A1+Wbjo76SnYOu9555ifOqMJZcVh/x6YlgqCjPNC5BHhoyxQRNYB?=
 =?iso-8859-1?Q?OpZz4OQBPG3YrfWC2sO3uiW9cf/o26a7Z7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: philips.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P122MB0281.EURP122.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: db0c54be-3305-4bd5-35f7-08dc7b2b26f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 13:20:44.6684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u2XW0nwswSUPUtbIB4ulx5tNPQGSRZzSyYoRe2allMU955WdgjLZ6QcYs9QRuYN5R1E+xPLM/1Mhgk6x5ex3V/awnQ0woLQHuqA2ZJjpx9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P122MB0276

Currently the only way to read the bootpart register
is to dump the whole extcsd register. This patch adds
the possibility to read the bootpart register directly
for situations where the whole extcsd is too verbose.

Signed-off-by: Jo=E3o Loureiro <joao.loureiro@philips.com>
---
 man/mmc.1  |  3 +++
 mmc.c      |  5 +++++
 mmc_cmds.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |  1 +
 4 files changed, 63 insertions(+)

diff --git a/man/mmc.1 b/man/mmc.1
index bccabf3..8aff106 100644
--- a/man/mmc.1
+++ b/man/mmc.1
@@ -59,6 +59,9 @@ Disable the boot partition for the <device> with <boot_pa=
rtition> set to 0.
 To receive acknowledgment of boot from the card set <send_ack>
 to 1, else set it to 0.
 .TP
+.BR "bootpart read <device>"
+Read the boot partition information for the <device>.
+.TP
 .BR "bootbus set <boot_mode> <reset_boot_bus_conditions> <boot_bus_width> =
<device>"
 Set Boot Bus Conditions.
 <boot_mode> must be "single_backward|single_hs|dual"
diff --git a/mmc.c b/mmc.c
index bc8f74e..26c4f13 100644
--- a/mmc.c
+++ b/mmc.c
@@ -126,6 +126,11 @@ static struct Command commands[] =3D {
                "Enable the boot partition for the <device>.\nDisable the b=
oot partition for the <device> if <boot_partition> is set to 0.\nTo receive=
 acknowledgment of boot from the card set <send_ack>\nto 1, else set it to =
0.",
          NULL
        },
+       { do_read_boot_en, -1,
+         "bootpart read", "<device>\n"
+               "Read the boot partition information for the <device>.",
+         NULL
+       },
        { do_boot_bus_conditions_set, -4,
          "bootbus set", "<boot_mode> " "<reset_boot_bus_conditions> " "<bo=
ot_bus_width> " "<device>\n"
          "Set Boot Bus Conditions.\n"
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 936e0c5..add9e56 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -233,6 +233,29 @@ static void print_writeprotect_boot_status(__u8 *ext_c=
sd)
        }
 }

+static void print_boot_en_status(__u8 *ext_csd)
+{
+       __u8 reg;
+
+       reg =3D ext_csd[EXT_CSD_BOOT_CFG];
+       printf("Configuration bytes [PARTITION_CONFIG: 0x%02x]\n " \
+                  "Boot partition: ", reg);
+       switch ((reg & EXT_CSD_BOOT_CFG_EN)>>3) {
+       case 0x0:
+               printf("disabled\n");
+               break;
+       case 0x1:
+               printf("1\n");
+               break;
+       case 0x2:
+               printf("2\n");
+               break;
+       case 0x7:
+               printf("user area\n");
+               break;
+       }
+}
+
 static int get_wp_group_size_in_blks(__u8 *ext_csd, __u32 *size)
 {
        __u8 ext_csd_rev =3D ext_csd[EXT_CSD_REV];
@@ -602,6 +625,37 @@ int do_disable_512B_emulation(int nargs, char **argv)
        return ret;
 }

+int do_read_boot_en(int nargs, char **argv)
+{
+       __u8 ext_csd[512];
+       int fd, ret;
+       char *device;
+
+       if (nargs !=3D 2) {
+               fprintf(stderr, "Usage: mmc bootpart read </path/to/mmcblkX=
>\n");
+               exit(1);
+       }
+
+       device =3D argv[1];
+
+       fd =3D open(device, O_RDWR);
+       if (fd < 0) {
+               perror("open");
+               exit(1);
+       }
+
+       ret =3D read_extcsd(fd, ext_csd);
+       if (ret) {
+               fprintf(stderr, "Could not read EXT_CSD from %s\n", device)=
;
+               exit(1);
+       }
+
+       print_boot_en_status(ext_csd);
+
+       close(fd);
+       return ret;
+}
+
 int do_write_boot_en(int nargs, char **argv)
 {
        __u8 ext_csd[512];
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 5f2bef1..12716b5 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -25,6 +25,7 @@ int do_writeprotect_boot_set(int nargs, char **argv);
 int do_writeprotect_user_get(int nargs, char **argv);
 int do_writeprotect_user_set(int nargs, char **argv);
 int do_disable_512B_emulation(int nargs, char **argv);
+int do_read_boot_en(int nargs, char **argv);
 int do_write_boot_en(int nargs, char **argv);
 int do_boot_bus_conditions_set(int nargs, char **argv);
 int do_write_bkops_en(int nargs, char **argv);
--
2.34.1


________________________________
The information contained in this message may be confidential and legally p=
rotected under applicable law. The message is intended solely for the addre=
ssee(s). If you are not the intended recipient, you are hereby notified tha=
t any use, forwarding, dissemination, or reproduction of this message is st=
rictly prohibited and may be unlawful. If you are not the intended recipien=
t, please contact the sender by return e-mail and destroy all copies of the=
 original message.

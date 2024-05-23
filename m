Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2228174C
	for <linux-mmc@vger.kernel.org>; Thu, 23 May 2024 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468982; cv=fail; b=N/KSRrgtOcKkUKiHBNPghMN64nRN1PknjOpJtySkP4SxuS/6RGln8E3/7hHVbW149DHFergY+wN8o1ypPkIDVoGkzHht5/aISIpeqbiG0/oTR/AXvHKgYDOt2mHc85pdpFFloNAXIRbYWadjzksykBeGOyQJdj34K2HJbFelWhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468982; c=relaxed/simple;
	bh=GDEeihPPMnSlrcvU52RAQuHuVZ5DKDR6YCjYhEwkyiI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GAsGaxTqaKoZIguY7y9nMMJdMca12Ik5YCHFgdB17SI/gTewCkJ2hI5mc2jTEqs1izG9gJ4fD26dKpCbiMJPxhY7NJuG/NbMgLDyyDxHWeRTJV+zmSoWkrAEtPiN3RyN2Ll7AeFgtqEwHUhugFB+yo5OsZU6yALivdfHitTUXyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philips.com; spf=pass smtp.mailfrom=philips.com; dkim=pass (1024-bit key) header.d=philips.com header.i=@philips.com header.b=ZOqGVwYh; arc=fail smtp.client-ip=40.107.22.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=philips.com header.i=@philips.com header.b="ZOqGVwYh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIPqu56aN6+TZZONveB91e64R4HVoK/5dNxwXbAjgqsM2gnxuw7FZ5jyNkUMdrVS50SAWasFPSdlESJuhXkh/Lvr2mo/5tEb9XsiFqtT00MCknaNvu4D8uzcSaaPNJo+tqvIskhZFvWcFqiMZ6Ps8Y41kAtBuKQMhV5iE8UAhWWEeuZHW1kIaLSBqXfR7fepLI5AkQiRIEA5fFuKuVpufBK2zEjF8VC7V9dzTmT2KVQrVl1bgYybj2Q9gqq1bcSl25w/VZx+Jt/Xr6gYxxJkrL09wdZQnH35RaMqmumdtxbgQTLUxjJRP9oZoziwLY5sqpBG9MTVC8x7V2mdrOvmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1BSjRJa4zlJj4uoQtM4TQAJYj7ecmu02x+r+pfyWcs=;
 b=aEd9NmS9n0fDHT6wvExb1P8JXKpMdie/0rTJ1/aimKbZbnQ+SQoZrbVuYfbBptPaDZCV/OLvE0exNBCH2dvN3aADhmPmaXjWCmqM5NceIYZBpsx3hta6IHa5aftImlyTTfmDPS2U0bd342+5wkodEmZNMt8dCw6vGHlOaE72vK1OBdSJVS2eYWsPk/AF7lC8QI3lJ5x9XKXCCdbgZk0CaBrxNOYWHGPSoIYGXVd8y1q6n0UCgXOC+qaW1LHX2MXLB37G8mWo+IHl17LiHZWaP+G/HFI1yEqrNg/BX4RxP0SEZhx++YF11DDEBsvRZKdpVYgD8RKJ/5dqjN5DjTfoTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=philips.com; dmarc=pass action=none header.from=philips.com;
 dkim=pass header.d=philips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philips.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1BSjRJa4zlJj4uoQtM4TQAJYj7ecmu02x+r+pfyWcs=;
 b=ZOqGVwYhlIpc3TxIIr51aebVRwFQzsEIBkfzPtgIygEBR987HGTPisKMca20ctXWaCxIWieugew9wXcQGkbUv7XAvDH7UneAbQp0WuwBM20CZXmBaX/6mVXc7KtJOwjH+ZB8GXgrfQbOCtHu0o/IZIeA2VZ5ogzjG6axWpyFF5I=
Received: from AM9P122MB0281.EURP122.PROD.OUTLOOK.COM (2603:10a6:20b:22c::12)
 by DBBP122MB0202.EURP122.PROD.OUTLOOK.COM (2603:10a6:10:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.40; Thu, 23 May
 2024 12:56:16 +0000
Received: from AM9P122MB0281.EURP122.PROD.OUTLOOK.COM
 ([fe80::2a31:e7dc:f131:1e12]) by AM9P122MB0281.EURP122.PROD.OUTLOOK.COM
 ([fe80::2a31:e7dc:f131:1e12%4]) with mapi id 15.20.7544.052; Thu, 23 May 2024
 12:56:16 +0000
From: "Loureiro, Joao" <Joao.Loureiro@philips.com>
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] Add functionality to read the bootpart register
Thread-Topic: [PATCH] Add functionality to read the bootpart register
Thread-Index: AQHarRANmhBF4ZCxpE6S3dg1Ljmf3Q==
Date: Thu, 23 May 2024 12:56:16 +0000
Message-ID:
 <AM9P122MB0281EA706B05ACFB3E0E2405F2F42@AM9P122MB0281.EURP122.PROD.OUTLOOK.COM>
Accept-Language: en-NL, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=philips.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9P122MB0281:EE_|DBBP122MB0202:EE_
x-ms-office365-filtering-correlation-id: 3e786203-3105-4572-8ed3-08dc7b27bbf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?YgtmtG1JzKMmaR6iP3VVriVIXy42Fnz488MlRcvraryWUL+l0yFYTPXRs1?=
 =?iso-8859-1?Q?mhS9x2EqOpUf72A+py5CE+1G0dAmpkLP4HYMQqe7ndDWGl1v9q/nViqSN2?=
 =?iso-8859-1?Q?tFBRjQ5cZe32Udb99Pw1thUIndRTmLjA60kP0uft9pjMWpnyuV/4u8wJX0?=
 =?iso-8859-1?Q?sIp4OOoiWYZCMTnGxNPY2RPwvDq37pVevsVZIhQlfDyoPa1XD28nj9wUho?=
 =?iso-8859-1?Q?bZzf+FGovvub70WwXa8zVPJCsZ6vfWyTDnz/AMvWRcQq8oUTY8H+ETf2wH?=
 =?iso-8859-1?Q?4fwkEtpHADKdFR6bvW+xNIxolWtgf0PfBArpgp/Tx2CYJ5u56Hsn528iDB?=
 =?iso-8859-1?Q?XQr0Yv6lgAnazURAj9A/TYHD/hGkKGkFC+Ld+OvbG/5L8f3ZsUG9+4eNJh?=
 =?iso-8859-1?Q?H8B/dOT1la4xP2HKDsz6ticr6rBfn1AJYTOTYv49iDQXZU74VGdEkq7hPw?=
 =?iso-8859-1?Q?UauwMr2DKPu8haZmwLVPmdgq4veEQHRyjPZXCn9DZTuMx65zcW2a9iYx09?=
 =?iso-8859-1?Q?MmGsJ5OKTCwmkhqjRkFbXEDjDSkhbuTcckVty/cfCPvkqAFnTT3yFZsKIB?=
 =?iso-8859-1?Q?s4e1uPTQ86Oheqy2MS3C32fb1dnFjXjzjuU4NVUWSOUMv7+Mnlankh7p3C?=
 =?iso-8859-1?Q?d3K4UM2cqibq/wHWBQDBiVwG5XJke8bxthV2HqvlDdEVpVbhIpsFPd/P+R?=
 =?iso-8859-1?Q?SGv9eEftf6pq5VgvSe1kZoF1ziSbe2TBV0BeHys7esP29W9IzV/VUFuIMH?=
 =?iso-8859-1?Q?tbmpeSfUVPInSfTBj4gc9dcgqnnTskp+zAk0vWyDOXEVyjzkPk2f2Ue5NI?=
 =?iso-8859-1?Q?ZgmjE0UVu4kwdeE3gMA++CbMWItKOoAna5DCwnhoka932jCClFRxaqDN6E?=
 =?iso-8859-1?Q?JhIZro3qjEV4m9/IRPiOHVF51GRJ0g2+PntDm78/uxOyDFvybQ52dTzxGB?=
 =?iso-8859-1?Q?Ox9dRVCkwiDVXz4nYQDcIGhmBnVYAVypG42jqeMhUWKZmy1gYj/A4R/T5b?=
 =?iso-8859-1?Q?4YM1tfpI6lU8E5+tKSbdbcjt/MdWcVuXIh0IU/8Xc8FJLhOmfn2gBU82Mz?=
 =?iso-8859-1?Q?+PkIkYY/i/bDI5hzazx2f80wY80vO5eHcJ1gphDnZPYzFER/dEkSfGCH6K?=
 =?iso-8859-1?Q?Ew0Dwb+qDg+jKaGI9UgyAZAKE0ZiPn3ko/pyJg5eL7hRfX23wjRpSOXFGj?=
 =?iso-8859-1?Q?HPNyhL5vFezbVFd8435+F7VRqxxtRWkkHplt00Znsx6zwc+B9UPy8IwkRn?=
 =?iso-8859-1?Q?W4HW6PBlrgl0VTNpib3nmyk0pkQo7zXHSb7wOgFg2PH14Cx7t1n1KESOEA?=
 =?iso-8859-1?Q?QYYrjPu4quntOm5h9etiKiI+1qiknb2c+i7JgW+YcjL8y3BrwiokOpkTHS?=
 =?iso-8859-1?Q?1+l4tS3aLt8Fm8v5M5NXWc38fFfGkzjg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P122MB0281.EURP122.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+jkZoypQV0jPN7rWQ40g2h0dbi6eccb8ghMDT8hOqLhbV1vBPaawdrhThD?=
 =?iso-8859-1?Q?MBkyXzTEHDIlUk5O0cGUPzHMuVhBakcUb6T5KB8Z1k1KKYdt6Fhv56p5Oa?=
 =?iso-8859-1?Q?6PY3BAOfliNAWTwFn85+O9l6edsx7SVaVEzENUS77/bys0nZ7/YXWvv0MO?=
 =?iso-8859-1?Q?K521YbhQ3L2X+f3hyB3lFmmNqNA7iacmnssw3k1W7b/PW94qUHCkFdjfTM?=
 =?iso-8859-1?Q?TYWK6k9I61A94Qx1PrRVKglycDSAqIzZU5b7Tp2cyucJzxyOkwbYLDbxPQ?=
 =?iso-8859-1?Q?GvI9d6GLUZR+pHiEfPIQoctsUqNLvBqDqdj1sRnqIddPT69odMHc/WU3AS?=
 =?iso-8859-1?Q?U423wW9nWsQwLz7ht5sFlzS+NDUhXKGFq19yF4spArzDjPiiDos+MjECrl?=
 =?iso-8859-1?Q?jHwHGiOUiUwk+AVWgSbIsEQX5ht3oChqdEBu9UanOiDyZ2mNOaXPX9RP8z?=
 =?iso-8859-1?Q?iNfRhXcg4I/PcrLiH2F7j+55DBaMysnu1obkm1o52pBuXAiyb3q7GIcKzV?=
 =?iso-8859-1?Q?ltYSWu78JpIznu86glSE1V9uJ4S/8e5JmocU2jb9uVET1awAcTlHdmdw+E?=
 =?iso-8859-1?Q?JFmEEpFX34FLj07fqu1GqFxAhfRUikanJjOGLpGAhwVzoaGS/hL26miOFd?=
 =?iso-8859-1?Q?UdtGSWc0wicrgw7EuJDmHvvCpr5cpr0bOkjpW7YPAU3D/MmbZddNELc8FJ?=
 =?iso-8859-1?Q?n8p4ekF4PNjetKTV1hg5NikdhXnWhTi9iMQqOxJi88lXFqxWyeB3c3ny1T?=
 =?iso-8859-1?Q?iW5RMvrnJNXUAsBP8ZJZMdPmkv7wQ5r/NnWT13tJIe8YVrNZv76/DAWEn0?=
 =?iso-8859-1?Q?930oqXe6msaHCtpAcQN8OSCXMFQ0+fTDrMYRVYOVNkIOZndnevwOp/bbqB?=
 =?iso-8859-1?Q?Lryi6AbITVJIyDE5MVyXVYLTVvpzHf1px9n6V9tZD3IZuA6cKCPOF1S2iH?=
 =?iso-8859-1?Q?RsyItJHUM1HQbbTybbXsS2rGltb2F6lrWQXWhmPpwmmFtXtuIBXWeYFrSK?=
 =?iso-8859-1?Q?LKy5KU2TjbUgil8NyRkoDsXLqfYjwohcGOETPniRwoDO3NtqZ8eU8oVVrm?=
 =?iso-8859-1?Q?3oNWYomYgsiD5UK0WRtpz852vZgABwN4hbDnpmC+YiWri6AK+/cT89ozQN?=
 =?iso-8859-1?Q?SqmX65UMq4BKilgFveTa1ePkMHhquKaqalWwv9VTkHlCDAIGoF+QO0Zw9o?=
 =?iso-8859-1?Q?Ph9rSjaEbnl3fjHTpC4tsoM231dMh0NJ4TF74c1IBWCgGUnz4EOGpEitF6?=
 =?iso-8859-1?Q?4iqVuk9pkoS+FYqI4JPpqjGpuzRwJsa5aeJvdF6tXgggUi5OH+s2Ksvkwn?=
 =?iso-8859-1?Q?47ZQnhEKDlfkn1WChvDc43VjWQ4BNdCIfjgszOTlyedshNHC7FGcOxIxmH?=
 =?iso-8859-1?Q?fTOLtw34wQIgMgRZjiRJzrSUhEhX4m9F6dQvmcKhPYAwW+NTgc26yG+QbZ?=
 =?iso-8859-1?Q?mw6eaVPU5ODh5YEgzb14A3UKdbiHwCulZJcjsIf3IalKpmSRzEu7xGMn+5?=
 =?iso-8859-1?Q?xa95HP4QVEnAI1L+Bb6D4ecKbu5BX701s8VpvwFEbnUMWKwGzZLGqthT6O?=
 =?iso-8859-1?Q?JmsTpKnIV9cBFKDRnjfI+/4S9+DlSvj1gGn2eERW9jugdkhURV0/LafrWu?=
 =?iso-8859-1?Q?zCSt0PRnWw+f+vDIZQYiZOMv5Sdxh37a4X?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e786203-3105-4572-8ed3-08dc7b27bbf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 12:56:16.6986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/y5nE6TAgVM9TkIhnilGZ0GSKeVSLAhcx9LPt6YkFIeepVf3U+HwmlquT/wTP5slNGSAG4jsxQ/WW+9TVLyBPxSbFLixLjC1nT4TFKTNso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBP122MB0202

Currently the only way to read the bootpart register
is to dump the whole extcsd register. This patch adds
the possibility to read the bootpart register directly
for situations where the whole extcsd is too verbose.

Signed-off-by: Jo=E3o Loureiro <joao.loureiro@philips.com>
---
 mmc.c      |  5 +++++
 mmc_cmds.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |  1 +
 3 files changed, 60 insertions(+)

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

Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAE0C4338F
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Aug 2021 08:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63CC661019
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Aug 2021 08:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbhHIIlm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Aug 2021 04:41:42 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:5302 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbhHIIlm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Aug 2021 04:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628498482; x=1660034482;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DU1g/T5dXElKAXIzpdruxb6PTcIKn4VMYYEnzci/P3Q=;
  b=kdwFCxqhA+b4Uq6S2AXj/obbKT8YtZmYzjyxvVFy3JJHEhuCgafobj2b
   PPcMRDnoPDl5p8KzkEHoxrlhlp3cN1damxcRpuLMx3xzkc999pnHUYOxr
   ge5+4MPiisniLvxFmAG6n3IWvncAt9MQBBqNU8VrLJtMy3/htbW111Ak4
   EpjlAGRDmbyyUrVVLoa+qUM4uXcllKqsI91cf9BFrWaLCfyETZm4D+l6n
   2aHUZvK9bM+AeSW05ywdP816N590dfMwvF4PmJIVz3FtFAt7t15r/plba
   gamKhAj/J8kTllf6aT/CihHv8RKW+HV5nvkd5lNKAPPbOBE6NxFnD8L3q
   A==;
X-IronPort-AV: E=Sophos;i="5.84,307,1620662400"; 
   d="scan'208";a="177226256"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2021 16:41:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dgr8PCTyglQJSl5+14KrF2NCtlAwbIWtw6zZ9wzBjO9uvvAq1bBW0fBUJDIknut2mYIjE+lo2ohxt8n18ZquVn0X0wgc/IuO1fK/0JRc438GGXmwxcVQlR9DmV1uije1sDmDUXu/sSRbN/CKSjR9jbJdviYlSJBLPR5O/V6hE5XDEBvr4kPoDKmVQcMam4XAGtYKDDnHYL7bNKfsmpbMAJInEtKEyXLmH6P+NPF0clIHbQ3X1w8wjKzpWuMNaLBg/uLjxxfYhC5m13VCVVhoC/XgxkBP6Vm4xDnja/RhJ66VkkY6VkK6BVQ78dIAvM83jXAoJEB9V0jYZHJlbRtcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3cjLLB3TJ3aHoVkp02Zsvq0XJEEPHQGPvwlD5r8imE=;
 b=c9WAEMCz9c2WPR+h4sOz5dxKSTvk2rFNm/C7cvyKJSZrKr0txmxuQ/mmAEBDtmQSTstiW3eG5sLrHmOX9KM0V7TSoktX93mrhyntjmfCWy5FxGscai33qFvalNis+8dAiN7FoeZH6eWQl5pTfl+0Ztzstr3xQLZ7HsWPm9oDa0RduJaWlvWWlUP+XdE9DbdW2gw/Kv8Euqn7WfzObPYkI88z4DgfSdoPTWI9738V4u5b3w4P2lzWsAzZviXBFqOO9kV2E25UNvo9slCMs09NwZChJdDewxlF3VfQ6b70o0ouhxpLXOB797WZY4ob1xyLy2O9FQX7lyN4H2bij2I62A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3cjLLB3TJ3aHoVkp02Zsvq0XJEEPHQGPvwlD5r8imE=;
 b=J46Urj6Vdkb5RZsAyTsk1cVqJFwBRNof0fCEPFVzB0CdaaofdTEAfdDTc+mwqkbrxynjHBDTV9jIhVNILCcs97upzyZIn98pDpFIIWhBzrPSXPzvyGlVVGDq7jSIGHtbGKbHzPx8ksfYrZUQm19nHyDxkte/GIXHopCepW85tAg=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB4428.namprd04.prod.outlook.com (2603:10b6:5:9b::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.20; Mon, 9 Aug 2021 08:41:19 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::b448:90b7:c333:40a3]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::b448:90b7:c333:40a3%6]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 08:41:19 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mmc: core: Return correct emmc response in case of
 ioctl error
Thread-Topic: [PATCH v2] mmc: core: Return correct emmc response in case of
 ioctl error
Thread-Index: AQHXjHpellXktnu2k0aKNPm/Pz8mzatq2HAA
Date:   Mon, 9 Aug 2021 08:41:19 +0000
Message-ID: <DM6PR04MB6575FA52433A1A3C7F89453BFCF69@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210808172448.4641-1-nishadkamdar@gmail.com>
In-Reply-To: <20210808172448.4641-1-nishadkamdar@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ed9125f-2264-4b43-205b-08d95b1175ba
x-ms-traffictypediagnostic: DM6PR04MB4428:
x-microsoft-antispam-prvs: <DM6PR04MB4428E3CBA1C53DDEE15C83D8FCF69@DM6PR04MB4428.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:93;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e4v+/yNCJFcTYqDo1MrL0swowdN0zqvaT3bSkunZfEuGSugUKkiTxKPexKLoIyYLXSNSS3NaQu6XiivsFQGUuFCAPAmDJW4MEPtAHCa+R0tOlHE3+nnI674SZodXfpO1gTT7Wjpz6MGpqhuQZoOjCbDhOBpEiEn+KG+FHtI29VVvEIXraK7poHpbLyJNooRCpzfB+vT7csN+BrFcnSYK7lAd3N6rrygSsfdxj5L3akGnTIbEZ/Ao2FCxiCUabTsEtzng0JWGZQV3nbpdTCPl3xfQcHEm1EvhbCGJU1G6yaRLA9B/CnCpa0A9A6wsOsgX99Yaa6GEiLbxxvmpU38Y/Mu0z3D5s/PK0yWnxB4X0vSeLDskBgM4DW1np91Xp9rXefjaiuebq76qJG4/27WfHbxIb9O/IrD9Wx5352sMBVKvCHlJRuU1fCYtevjzHx9Ri7nLfoHYI9muMVpIU8mXAAazlD/x1YN6n8Qqi3UbWQdunhmghoFbBulPJWjVHJ7qvOlP8RLm/2PhmrWwmi7nujdhvqdXvaqhtVgmCi3XzIETK2Luee8kgGRNdU1eZ9McpnUXhwRQfAmuV/u78pa5yy/3mE1QPgSTcC7sseNtNB7fQO3yBQzgMyCI3hpaVBo9VLXSnLCTgOE+7KheEpBQt5evhMSreRBBen4sUPI4sv7U+TI3Gt3gpSzpz1V7z3TzlzIgqq9eglNh6IPnIdqZdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(64756008)(66476007)(66556008)(66446008)(76116006)(66946007)(186003)(71200400001)(86362001)(8676002)(9686003)(6506007)(55016002)(26005)(83380400001)(2906002)(4326008)(33656002)(38070700005)(478600001)(5660300002)(52536014)(8936002)(7696005)(38100700002)(316002)(122000001)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Ple2/eT+RcicRWLibyuQHcHIZfYj7WmDU54w/zC5YIKuh/cAUwt0w/toxgT?=
 =?us-ascii?Q?oC56KrFI9xXBm0cFHZV5YVuhyd3Y5gZ9D9rx4z0m8Gq445s9716gt+E/0LXA?=
 =?us-ascii?Q?EwlHBAZSrRwmwZp7hHdiVNxLx9sHC9tSuKIKM9h/6z1o3aQNLYhgRgRTaGmK?=
 =?us-ascii?Q?ZWML1GUzvdqpa6wAEi4If0XihfLM1PmzzoaO4oDg1rn3zg3gNUL8A2lKJgma?=
 =?us-ascii?Q?NfTNyzQDtsZVNzO8uKCKjxB6tYFWdn9Kei/bbOVKbLDdN5zbiqP4hsLPO1Fl?=
 =?us-ascii?Q?lUo59JOJTEeiiKRZpICEbTdLHgtvlOP2udX+a7yZXQFCW/5y6MplGuzmqoXt?=
 =?us-ascii?Q?UyM+hkSNf5AX1vziN4ZhUfvAKaJrwpgn2kvtzjri6SAE83fcJx6vezMO3YnQ?=
 =?us-ascii?Q?PYKmlF+XstfDK6lb6mNKbidLfyF4q5rPG14cEaDJx5TRXAxTKzaD0ZAI0Jz/?=
 =?us-ascii?Q?mNfdyvtBwNNkAjWCNjIndRQl7oEWhFFMwnbNSnyz0ZdEu69A4FFxvmRpCvgu?=
 =?us-ascii?Q?GU2TJZsvBLRf2Fp7slIG/VZ5Fd9OYcrhy6fwzh8ES/nh6q0BXI61lIAz8xal?=
 =?us-ascii?Q?il4NxtXdpTo1TAUulE33p1MSuySWqqqtQ8goA3jhPR4i1IxZekPmtkrKRYbs?=
 =?us-ascii?Q?s5fBfjVyM9qxbVttL+6LQBwkUldnL+oLb6X5X9xibhPHWKgndC8OnquX+iTm?=
 =?us-ascii?Q?M6uxnbMHfmYkRVKRffJ63l3m+QNYgSI6yfVHGWQxkGWaN7gn6ZA+bPhOSyuV?=
 =?us-ascii?Q?gHDpJWxhCQVJUQVEOYmd5mSTYEZZzCrz4R7OxQ1mCnJGgJLbfq8wrYyibBxf?=
 =?us-ascii?Q?slDF3pOoJW1uvwNnuYYc4pSe872myZFixAKKKOK4ME0QHco1eQgqxMLrfjN2?=
 =?us-ascii?Q?gjLZOY0tUBn7UaG7NdCrAj/+vvghgggpCOq6zMge4XlzGwjo/HW0EUMTvfoh?=
 =?us-ascii?Q?4I6p49ebYVWh9/RBPeIKyomJepKHdXkfyUr5LyZ0//0r0JAYpdeFGwAzJgAg?=
 =?us-ascii?Q?yFUggrbIxS+pAQFLTTdr9EQYNDLXmvwxTPFofzdVe5I8urIwexdye1jSdup8?=
 =?us-ascii?Q?e/hmI2376Uf+0OnUOtH8re94Ppo8jsA12TI59zuN+a57tVbwEcD/UD4w+eSz?=
 =?us-ascii?Q?m1VbgjKLZzvDDup8ZE5R/VIRiMny+7X/0lDwvuaaygcO80H8AzLr34zN833s?=
 =?us-ascii?Q?1o6Xdwp6diSCte3lQvpEmzY+yf5oIGb7UVD0pTpS6RgkpiezFa+s6cDZYyaP?=
 =?us-ascii?Q?CoaA0oFH6yF6UGK0xFdNfIUFQDffpl9JezclAVrsHBYXmd5Ug0SvV4UedOus?=
 =?us-ascii?Q?9f5mpa66b7r/N/lpKygGcqXT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed9125f-2264-4b43-205b-08d95b1175ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 08:41:19.6354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vpW/kWYbKWC65ZGxc8P0NOdVCNserJdmMPHRRb1OhtTEOC+vuAJwoSdkNisLfHTSwtrkRufmV1s2W6SmEa6suA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4428
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> When a read/write command is sent via ioctl to the kernel,
> and the command fails, the actual error response of the emmc
> is not sent to the user.
>=20
> Following are the tests carried out using commands
> 17 (Single BLock Read),
> 24 (Single Block Write),
> 18 (Multi Block Read),
> 25 (Multi Block Write)
>=20
> The tests are carried out on a 64Gb emmc device. All of these
> tests try to access an "out of range" sector address (0x09B2FFFF).
>=20
> It is seen that without the patch the response received by the user
> is not OUT_OF_RANGE error (R1 response 31st bit is not set) as per
> JEDEC specification. After applying the patch proper response is seen.
>=20
> The user level ioctl testcode for the above commands and their
> respective outputs without and with the patch are shown below:
>=20
> CMD17 (Test Code Snippet):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>         printf("Forming CMD%d\n", opt_idx);
>         /*  single block read */
>         cmd.blksz =3D 512;
>         cmd.blocks =3D 1;
>         cmd.write_flag =3D 0;
>         cmd.opcode =3D 17;
>         //cmd.arg =3D atoi(argv[3]);
>         cmd.arg =3D 0x09B2FFFF;
>         /* Expecting response R1B */
>         cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
>=20
>         memset(data, 0, sizeof(__u8) * 512);
>         mmc_ioc_cmd_set_data(cmd, data);
>=20
>         printf("Sending CMD%d: ARG[0x%08x]\n", opt_idx, cmd.arg);
>         if(ioctl(fd, MMC_IOC_CMD, &cmd))
>                 perror("Error");
>=20
>         printf("\nResponse: %08x\n", cmd.response[0]);
>=20
> CMD17 (Output without patch):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 17 09B2FFFF
No need for arg 3 - you are hardcoded overriding it.

> Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
> Entering the do_mmc_commands:Device: /dev/mmcblk0 options[17,
> 0x09B2FFF]
> Forming CMD17
> Sending CMD17: ARG[0x09b2ffff]
> Error: Connection timed out
>=20
> Response: 00000000  (Wrong response)
>=20
> CMD17 (Output with patch):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 17 09B2FFFF
> [sudo] password for test:
> Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
> Entering the do_mmc_commands:Device: /dev/mmcblk0 options[17, 09B2FFFF]
> Forming CMD17
> Sending CMD17: ARG[0x09b2ffff]
> Error: Connection timed out
>=20
> Response: 80000900
> (Correct OUT_OF_ERROR response as per JEDEC specification)


>=20
> CMD24 (Test Code Snippet):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>         printf("Forming CMD%d\n", opt_idx);
>         cmd.opcode =3D 24;
>         //cmd.arg =3D atoi(argv[3]);
>         cmd.arg =3D 0x09B2FFFF;
>         cmd.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
>         cmd.blksz =3D 512;
>         cmd.blocks =3D 1;
>         cmd.write_flag =3D 1;
>=20
>         memset(data, 0xA5, sizeof(__u8) * 512);
>         mmc_ioc_cmd_set_data(cmd, data);
>=20
>         printf("Sending CMD%d: ARG[0x%08x]\n", opt_idx, cmd.arg);
>         if(ioctl(fd, MMC_IOC_CMD, &cmd))
>                 perror("Error");
>=20
>         printf("\nResponse: %08x\n", cmd.response[0]);
>=20
> CMD24 (Output without patch):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 24 0x09B2FFF
> [sudo] password for test:
> Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
> Entering the do_mmc_commands:Device: /dev/mmcblk0 options[24,
> 0x09B2FFF]
> Forming CMD24
> Sending CMD24: ARG[0x09b2ffff]
> Error: Connection timed out
>=20
> Response: 00000000 (Incorrect response)
>=20
> CMD24 (Output with patch):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 24 09B2FFFF
> Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
> Entering the do_mmc_commands:Device: /dev/mmcblk0 options[24, 09B2FFFF]
> Forming CMD24
> Sending CMD24: ARG[0x09b2ffff]
> Error: Connection timed out
>=20
> Response: 80000900
> (Correct OUT_OF_RANGE response as per JEDEC specification)
>=20
> CMD18 (Test Code Snippet):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>         printf("Forming CMD%d\n", opt_idx);
>=20
>         cmd.blksz =3D 512;
>         cmd.blocks =3D 1;
>         cmd.write_flag =3D 0;
>         cmd.opcode =3D 18;
>         //cmd.arg =3D atoi(argv[3]);
>         cmd.arg =3D 0x09B2FFFF;
>=20
>         cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
>=20
>         memset(data, 0, sizeof(__u8) * 512);
>         mmc_ioc_cmd_set_data(cmd, data);
>=20
>         printf("Sending CMD%d: ARG[0x%08x]\n", opt_idx, cmd.arg);
>         if(ioctl(fd, MMC_IOC_CMD, &cmd)) {
>                 printf(" error ioctl \n");
>                 perror("Error");
>         }
>=20
>         printf("\nResponse: %08x\n", cmd.response[0]);
>=20
> CMD18 (Output without patch):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 18 0x09B2FFF
> Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
> Entering the do_mmc_commands:Device: /dev/mmcblk0 options[18,
> 0x09B2FFF]
> Forming CMD18
> Sending CMD18: ARG[0x09b2ffff]
>  error ioctl
> Error: Connection timed out
>=20
> Response: 00000000 (Incorrect response)
>=20
> CMD18 (Output with patch):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 18 09B2FFFF
> Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
> Entering the do_mmc_commands:Device: /dev/mmcblk0 options[18, 09B2FFFF]
> Forming CMD18
> Sending CMD18: ARG[0x09b2ffff]
>  error ioctl
> Error: Connection timed out
>=20
> Response: 80000900
> (Correct OUT_OF_RANGE response as per JEDEC specification)
>=20
> CMD25 (Test Code Snippet):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>         printf("Forming CMD%d\n", opt_idx);
>         cmd.opcode =3D 25;
>         //cmd.arg =3D atoi(argv[3]);
>         cmd.arg =3D 0x09B2FFFF;
>         cmd.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
>=20
>         cmd.blksz =3D 512;
>         cmd.blocks =3D 1;
>         cmd.write_flag =3D 1;
>=20
>         memset(data, 0xA5, sizeof(__u8) * 512);
>         mmc_ioc_cmd_set_data(cmd, data);
>=20
>         printf("Sending CMD%d: ARG[0x%08x]\n", opt_idx, cmd.arg);
>         if(ioctl(fd, MMC_IOC_CMD, &cmd)) {
>                 printf("\nerror ioctl\n");
>                 perror("Error");
>         }
>=20
>         printf("\nResponse: %08x\n", cmd.response[0]);
>=20
> CMD25 (Output without patch):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 25 0x09B2FFF
> Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
> Entering the do_mmc_commands:Device: /dev/mmcblk0 options[25,
> 0x09B2FFF]
> Forming CMD25
> Sending CMD25: ARG[0x09b2ffff]
>=20
> error ioctl
> Error: Connection timed out
>=20
> Response: 00000000 (Incorrect response)
>=20
> CMD25 (Output with patch):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 25 09B2FFFF
> Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
> Entering the do_mmc_commands:Device: /dev/mmcblk0 options[25, 09B2FFFF]
> Forming CMD25
> Sending CMD25: ARG[0x09b2ffff]
>=20
> error ioctl
> Error: Connection timed out
>=20
> Response: 80000900
> (Correct OUT_OF_RANGE response as per JEDEC specification)
>=20
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
> Changes in v2:
>   - Make commit message clearer by adding test cases as outputs
A little overwhelming IMO

>=20
>  drivers/mmc/core/block.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index a9ad9f5fa9491..efa92aa7e2368 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -522,11 +522,13 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> *card, struct mmc_blk_data *md,
>         if (cmd.error) {
>                 dev_err(mmc_dev(card->host), "%s: cmd error %d\n",
>                                                 __func__, cmd.error);
> +               memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
>                 return cmd.error;
>         }
>         if (data.error) {
>                 dev_err(mmc_dev(card->host), "%s: data error %d\n",
>                                                 __func__, data.error);
> +               memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
>                 return data.error;
>         }
>=20
> --
> 2.17.1


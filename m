Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19679C00140
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Aug 2022 15:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiHOPw0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Aug 2022 11:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiHOPwX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2022 11:52:23 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE69417077
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 08:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660578742; x=1692114742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YD6cVuXvGeNySX+rIbRY8vTIGQCYfMK9hE/yCX498X4=;
  b=gQKO/RqzdAEeoWxsTERlVfk7/k3FmKgYOeaKJTsMfeqaSCQlrX/DWDDm
   Eq+mQuyIkdZjUfbRmdFSbxUx2xY5QObP/D7+59dIc5Rlz1NVph2j+ri+A
   Ul2TqBE9vatuQT5CMjXe1gJupDGyiDnpj9ukmiTnQdilWbQjqVXMy8rKt
   XhznpjdrXskAhJ+K6lpHAgia4ZqnUAH6dhm1U4wrblWOoKP3M89XR8Ywe
   fn8qwLxNTr1KsKHhsc46koJfJT3yq3qYEQwexp5WxbR4nGo0uYeP+onNc
   nMLN0wPGBJt3ATJZU9fR0nFpXyGjdpT0Qiub3cLwCRtE/VJPfv3w/bz7V
   A==;
X-IronPort-AV: E=Sophos;i="5.93,238,1654531200"; 
   d="scan'208";a="207225976"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 15 Aug 2022 23:52:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AY5fdtozIPUNbnu3okqpb8q1UiorWp+KnICYQ8yb6jlJKAR2DpcR65oJgU67CIjjEtT/dhCNEkuDpUIItAjtUDx81TCbapAPE8c9YI2TZ5eiXr8KdCkxgVDjraak3c8wWgOHbZi19qOtajdH/3iGX/HxN7tww1/E/begwk39AiI8AVV3zNalJq3q5d+YBNfNIU7A9kw6BcXGm2JJW9yi5cGRgoCDYtIRQUxoldFZ8bYIsEoSHTywTKNC22Ch/sCED0kpLxEzMdIsYUijTwpDevvXbcY/v6ZI/ZxOEPAQFvTJvB7bl3Z7BD+CfyOKtzj3cljsxzdIsO39xmxcpn+EOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+w0/pZabf8aNbPnFGKfo1MkpoaEXM0nKvyKrfSgj5w=;
 b=nuEXT0xmN2HQLdt+b1bVYPM1rqbZ/+MZA0TGcgz5LpKIQm8g5V3NTsPdY5XPJtoWCdweGYkGdiIzTPhD1GawCAnbr5D6fReqAOPDvi32EY8oohHCjzDsE+ntgFBCta5oOyy4PA3kBaVhfnCL+EPiVVsO/524aeHZrtKiOGWT7AtStcTS8C+cdqXJs+NGkl9ymNQ4bPBxRekyBaF8m6LnlrRnCjlhme29YywEGMCcB4T70YGtl2/5ZNAMPs+nLh5jckJ5bcUKMO9T4mzt0syeyjeG0aiVaqVFku46VItFL430AOGhyVO5A1ITB+HQo1JZw18w7yTrmfOBgOpHLxTucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+w0/pZabf8aNbPnFGKfo1MkpoaEXM0nKvyKrfSgj5w=;
 b=CmYniuDcOfaOr32zJHkz5IRuE/nQj0aS7OEfFCabLMaR2uwlHKMaBxA7Q0lzs/Hcxq6Fhj3nwiPI3iDmOw6cyNb2wOYpQ/0MUGH1XpM9SLCbd2Nk5L3O8n4pMIYRW+UvtJx7KnvsmupAV4DCCQfme2zQ6SyGvKZqeXFGTapjpY4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MWHPR04MB1089.namprd04.prod.outlook.com (2603:10b6:301:44::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.19; Mon, 15 Aug 2022 15:51:51 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%9]) with mapi id 15.20.5525.010; Mon, 15 Aug 2022
 15:51:51 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "Matic, Bruno (Nokia - DE/Ulm)" <bruno.matic@nokia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "Rossler, Jakob (Nokia - DE/Ulm)" <jakob.rossler@nokia.com>,
        "Heinonen, Aarne (Nokia - FI/Espoo)" <aarne.heinonen@nokia.com>
Subject: RE: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Topic: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Index: AdiK+e63vfHiFbPsQZCmC+FOzGq/7QAPwi0AABQpUuABmc8nMAACAULgAlKINPAAMpvpoAUetmXQAAXdPWAAAhdXwAAFcYuA
Date:   Mon, 15 Aug 2022 15:51:51 +0000
Message-ID: <DM6PR04MB6575A94E6D218F2272AF0659FC689@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <AM5PR0701MB2964A49C4E5EEA8905926120EFB89@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB6575A3FE605E0AE1C92B4EB1FCB89@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB2964B04050F05216BDFC638AEFBB9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <AM5PR0701MB2964D76967437E61EF42731DEF839@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB65750D9A332093DBA5B30BDAFC839@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB29641DB9207CDDD1DB273075EF8F9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB65759D709D6C45AFD03EB4B1FC8E9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB296429322BA0EEB2CE0B23FBEF689@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB65756EA45A10629F2EA8A870FC689@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB2964D0B47A64F62402ECC43BEF689@AM5PR0701MB2964.eurprd07.prod.outlook.com>
In-Reply-To: <AM5PR0701MB2964D0B47A64F62402ECC43BEF689@AM5PR0701MB2964.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10b4b7a6-182e-4776-1989-08da7ed611e6
x-ms-traffictypediagnostic: MWHPR04MB1089:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: POhsvTz7/U1VnKgVi7NTJV5mjoU9V7NXoIdf7T5ME0+QfbDIEpRMlb+Iz7/g35tggMwUC/ZfpVKiEB6pBSi4oDwCMI5NgA3brXn6FdDOeyNI2etGjf9zePp0GbJlX4Y5FkrFtZKPctL4E2/kjvattg5vfAMs+coZD6bG2QaWKywF1ngi2q+NnnXQ5GDqzrhDxzaBKdrPiySlT7G96Ll1FKNpPKJ48vl1xfCtgepoUKVgF9RMbYxvzVPT/Ip1HXKo9rAv2CF+2DJwpZOEv6NXHa3bUffGU4ch2Iuo4uGZmwuT3a9n6vxaPDHLXrAEuIfy/+lyQ5eu4Qj5EKgCoe9RfTcy5sHwHc4YybqBgNSqqKtp69naFExoKkoGBDqbHmKHa+IM+LhQOaYR5Bh5ZtAZw9/+8n9of3hVuqSv9vK3bj8ZnfMPW1qP8lVB9uvji79+SnCElzl1BMnLbcwWCEuTeITnDh1AE5tmSpCJKN07u0nTjwCw1A/uKGbiHOpR1n9j2jKFZr5fCtpZJcBo9VmLYEsYBbYR8A5uwXJxyhIS3dyqoo4mWGrgQTH6nO29bKz0qicgEgPF2ehfDUjYTANkZB3YGyZOMSFN34zfCSXQztmfGxYtcsWKeRieRmu2DJz4fy+QrjBaCIeEqDVLJBiuhesjVMHGIUljT14/It7OZEQsKadprXTiVnhQ+4Rr6BozMffEdB6vcum3WoCAyRYAe6BfiX+aZCSLrfjgD4UE+8dv9fGS9M2WTbDMveLh0HbXiAmrm10haZ1y5iSKsS+QagJIfn+agoE5TwRNZWwJjM++8LYocq170/PlF3uhPylF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(9686003)(82960400001)(26005)(71200400001)(478600001)(7696005)(6506007)(86362001)(186003)(83380400001)(41300700001)(38070700005)(66946007)(54906003)(316002)(55016003)(5660300002)(64756008)(66446008)(66476007)(66556008)(8676002)(110136005)(76116006)(33656002)(4326008)(122000001)(8936002)(52536014)(2906002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rmszierKZhjztVHJk52l0DSqaE4VoawmU/mDrbH19JK46d4wV770jO2DWg?=
 =?iso-8859-1?Q?d8V1KA3iaksX5VpqlBElljpPFcg9De4vZFB+27ZD02rN1OR8XbkHn/OIfs?=
 =?iso-8859-1?Q?zBSOY8ir9fFQdnBCqd9AyAjbDpOvqE1gB/wSK7Jfx9o880HwL1LDMgzbAA?=
 =?iso-8859-1?Q?v1wPTVYGNR9g232E65hecZ8KNgODw97UI2oQ9wxiGsvLOAZzBDEpuJOMLg?=
 =?iso-8859-1?Q?DpX9YT3Wie+dJOOvUwhrIfWOwxnTRcxUznJG0CqfnSOgY5vD4aLLe2sAnG?=
 =?iso-8859-1?Q?eAnlirVBgkTQrUH4HOY+y/mTeM8t8xNo269dThF0Wu11ksvMJ23a/Q9yAU?=
 =?iso-8859-1?Q?Oyckf4frxwt54vc/T7Rsd9fwy3XRUJg7RtVd0VEPNzIDEZ3cl2bH/9CcMa?=
 =?iso-8859-1?Q?eJFl6DqcGAah/EEgCWoMt1ZKSJKL/i+NfvDxtE4LYuQIi54rh6hJdbXGKY?=
 =?iso-8859-1?Q?4Z0vcEwbRIDulakRi4dOBvvl/vLh8XjdRNS3Xgv/NY6u8fVAnXX3EuC+WT?=
 =?iso-8859-1?Q?x67Il52i1v0qIQEkB3hOug38DiiaZjE0dqzh7HG95axyY4xuo+ypdBJUiG?=
 =?iso-8859-1?Q?4tBAV+GJcFJOZSoThQmXzGh3rPe01Q2TCChxcYF6FRu7hTRZizBKkrmiXP?=
 =?iso-8859-1?Q?0QpPn2w6ql/pzJMrM4AGVNsaRBFtLtnebQ433cKd0Rn1uGd8LoZjIbk5jf?=
 =?iso-8859-1?Q?oLGO8ei9VNke9NrSe6h/vLEyiEJe9m5FTpdyMxHnz49WuXrAuNFycIzfqq?=
 =?iso-8859-1?Q?40aR1dPmfpd1FGGQpo6zsAmzTtuVGvbrC+PyVtxX5yqbnU5Z4mW5thPj5i?=
 =?iso-8859-1?Q?g4D9zch4gB9M50R99KE4c6xhXZG3DYS0tJRnenW7hIncN6Is+VdnIB+uq4?=
 =?iso-8859-1?Q?ezSt95XznFU0Kj+BAJ74lczQWmOKUZqni10QFzRG7iRPCNJafE0m2qVGEP?=
 =?iso-8859-1?Q?CahABtRm7jnv7Rx9QRX/i5+mVxiChDjYAQTJ8k0M2Mli8+D5iaUGHplNGk?=
 =?iso-8859-1?Q?ItQ/UaPCNp0D5wmcr26SpkOkDVbqFqTFk851V/tjkyMGpW4nAnrPKrlHPR?=
 =?iso-8859-1?Q?8T92wYcX9cvDgkfE6rAgXogIxm3jLCS6stFqBH9tgJS3Zd0FyPe79lVQDT?=
 =?iso-8859-1?Q?DmPgOT+7qdXup7zPQh33giNsqYmkheKtRbQhA0iAbt9VhlHEHz/7S/gWfv?=
 =?iso-8859-1?Q?lAYCwZ+vcReYQVePIG5N9rIuWlHTLymx+3jHsWWDx7HOy8N9JjDPYg3hsE?=
 =?iso-8859-1?Q?NB4vJ1DxbxezVLjb95rz6iQw3SjF/+xnLuHCXDtGOPNw4fHAUAD3lqvnbK?=
 =?iso-8859-1?Q?chHBPVshI6wO+pzEvTfTS8FrbTaC+lLjGaksqOJxQiQHS2P9UyLdDQ0zcy?=
 =?iso-8859-1?Q?vNxn9hpnJuaKHOPtKM3Uo3PwFpHCOHjtnXwLN8mjAfsavEYf6iBnC6L+Pf?=
 =?iso-8859-1?Q?iw8js2z3jYZG1e8zzmGpLtpy2OqY5msnkFTUAEvZOG7sPf3VDRwSydxUgR?=
 =?iso-8859-1?Q?FxLErRmoWlj20pwX2sEs39wy1laiWlIIDISZ7DvO+rSsbvwe5pXVLvbDW6?=
 =?iso-8859-1?Q?36oFZf4gQ0ABIi8lUFNjSEQeb7DCWudnQ/0EvNKw2t8NZ5z1fk7QGvTnHn?=
 =?iso-8859-1?Q?SpoqFs4s3uSMqdoP8pZXroAAgKmaxo6LNa?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?sY/glhpE76qB7E2+gnHwvxFApDdSusnMjLCZeweF1q8Q/fGa9PaEzGVh0Z?=
 =?iso-8859-1?Q?2y79TAv2kjK3AZTHJs/ohpjMljOHtUs/Yjn4yQVOGnAgBx53C4XXSnusOS?=
 =?iso-8859-1?Q?aIIOGHMyqnfF2uSfh9at+i+fQiTZAeDhO9dnOhE9iGIcjJVbNAZoHOgLSJ?=
 =?iso-8859-1?Q?xWCW/tf1r33Tr5muv5j+SYin7ZOsPah+MmI1PXWKaY/DCyn1y9DKBVrZeG?=
 =?iso-8859-1?Q?rOivbkOzg0nQ+P7rqR+/aKtWAifdh8y0fdwLZ1szuT3++VNkUP8wkvw10A?=
 =?iso-8859-1?Q?ypxWfl0YmeepaB4q37qhZViBFsG0EN/PWv20td8EurOl8QVkCyWQWU0TD1?=
 =?iso-8859-1?Q?QIV7kYc9LIwQXsL7VbrbJUIVaVo6IRKsiDB0l0Y84Cz14incDCDP9I2Iqe?=
 =?iso-8859-1?Q?o2iYCd2SovhhGBrbQUQZnRQOm/4+0oXI4zX2PfRKluBKBdKcYUYwMJjm+b?=
 =?iso-8859-1?Q?dIChJhhYoKlhU5d8CWc2duNgr455KAFfvFiH+LzpsXZXNe9+AH2hUBrXRd?=
 =?iso-8859-1?Q?wmYfGgdQU/V/xAo0bhW0gcrat/dMt9/aBHy7v5kANbDhanPa/FNo7qsvTY?=
 =?iso-8859-1?Q?AfuVtFsUYRb9jFAnFhldK+O9GdyY7S///tTEr8U4lw++DSg6w1jzr2OD8g?=
 =?iso-8859-1?Q?0pVwkI28IE4FoQmEZew+0bTYOcVweuJ0r+us+nyGYNOeBZSKCex77dv13m?=
 =?iso-8859-1?Q?ecKXg5MUcYSfN8IHvu3m+22Dn7sKa/kuRUOosR0rpk1cNJ7QuOnVh3ewCb?=
 =?iso-8859-1?Q?8SimHTm3Rogohc8lHR7OR6mOLNoTxjQvz/rtJLX/Xyni8LZWHrNZQs7ukZ?=
 =?iso-8859-1?Q?FDA+Jbl0zpfXAqQWxOfbbeu4VhvnCc8hsbbVKB+Sb7agOtmk7wx8HJWKE3?=
 =?iso-8859-1?Q?d5AhhuIRqf/DCWHJiDZpL1/n0nBSUFfq70DSPhrb3w7py7vjeBXLVjFoC8?=
 =?iso-8859-1?Q?rMw013JxA5DzdnCiwO34rhKN62OiZ4ej7Sz+DGKoj3Fh/cPSBD8pTdIcUo?=
 =?iso-8859-1?Q?Bsj5vUHG+mfE0KSXo=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b4b7a6-182e-4776-1989-08da7ed611e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 15:51:51.4583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ahXNRRu6x1SvLlwihc8RQRCzhCb5pbaWMwron9fqxv7wUcPnKM47hV4Kh7dUswQ9l8pfGJhah5AfQD+fL+o3Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1089
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>=20
> Hi everyone,
> As said, here is the reworked patch.
>=20
>=20
> Add the check if the whole firmware was loaded.
> Cleaned up the leftovers of handling the file in chunks.
>=20
> Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

Please try in the future to properly mark your spins ( -v option of format-=
patch) - would be easier to follow.

Thanks,
Avri=20

> ---
>  mmc_cmds.c | 66 ++++++++++++++++++++++++++----------------------------
>  1 file changed, 32 insertions(+), 34 deletions(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 70480df..7d37e93 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2812,7 +2812,6 @@ int do_ffu(int nargs, char **argv)
>         __u8 *buf =3D NULL;
>         __u32 arg;
>         off_t fw_size;
> -       ssize_t chunk_size;
>         char *device;
>         struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
>         __u32 blocks =3D 1;
> @@ -2925,45 +2924,44 @@ int do_ffu(int nargs, char **argv)
>         multi_cmd->cmds[3].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B |
> MMC_CMD_AC;
>         multi_cmd->cmds[3].write_flag =3D 1;
>=20
> -do_retry:
> -       /* read firmware chunk */
> +       /* read firmware */
>         lseek(img_fd, 0, SEEK_SET);
> -       chunk_size =3D read(img_fd, buf, fw_size);
> +       if (read(img_fd, buf, fw_size) !=3D fw_size) {
> +               perror("Could not read the firmware file: ");
> +               ret =3D -ENOSPC;
> +               goto out;
> +       }
>=20
> -       if (chunk_size > 0) {
> -               /* send ioctl with multi-cmd */
> -               ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> +do_retry:
> +       /* send ioctl with multi-cmd */
> +       ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
>=20
> -               if (ret) {
> -                       perror("Multi-cmd ioctl");
> -                       /* In case multi-cmd ioctl failed before exiting =
from ffu mode
> */
> -                       ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> -                       goto out;
> -               }
> +       if (ret) {
> +               perror("Multi-cmd ioctl");
> +               /* In case multi-cmd ioctl failed before exiting from ffu=
 mode */
> +               ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> +               goto out;
> +       }
>=20
> -               ret =3D read_extcsd(dev_fd, ext_csd);
> -               if (ret) {
> -                       fprintf(stderr, "Could not read EXT_CSD from %s\n=
", device);
> -                       goto out;
> -               }
> +       ret =3D read_extcsd(dev_fd, ext_csd);
> +       if (ret) {
> +               fprintf(stderr, "Could not read EXT_CSD from %s\n", devic=
e);
> +               goto out;
> +       }
>=20
> -               /* Test if we need to restart the download */
> -               sect_done =3D ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
> -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] << =
8 |
> -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] << =
16 |
> -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] << =
24;
> -               /* By spec, host should re-start download from the first =
sector if
> sect_done is 0 */
> -               if (sect_done =3D=3D 0) {
> -                       if (retry > 0) {
> -                               retry--;
> -                               fprintf(stderr, "Programming failed. Retr=
ying... (%d)\n",
> retry);
> -                               goto do_retry;
> -                       }
> -                       fprintf(stderr, "Programming failed! Aborting...\=
n");
> -                       goto out;
> -               } else {
> -                       fprintf(stderr, "Programmed %d/%jd bytes\r", sect=
_done *
> sect_size, (intmax_t)fw_size);
> +       /* Test if we need to restart the download */
> +       sect_done =3D ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] << 8 |
> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] << 16 |
> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] << 24;
> +       /* By spec, host should re-start download from the first sector i=
f
> sect_done is 0 */
> +       if (sect_done =3D=3D 0) {
> +               if (retry--) {
> +                       fprintf(stderr, "Programming failed. Retrying... =
(%d)\n", retry);
> +                       goto do_retry;
>                 }
> +               fprintf(stderr, "Programming failed! Aborting...\n");
> +               goto out;
>         }
>=20
>         if ((sect_done * sect_size) =3D=3D fw_size) {
> --
> 2.29.0


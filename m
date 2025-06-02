Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3BA22759C
	for <linux-mmc@vger.kernel.org>; Mon,  2 Jun 2025 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877448; cv=fail; b=sBDerNr2l7kTFKV3H4BD8C6R6LVck9Jp1P67kGV+tf8wjueCGtXYB4eNLXPfYp29MF05BFpztdU4haS1xDLtePQxhwrff8NgRY8+KT39d1OavcYqRkSoS7NkgrXLoxeQZlh7nlZAAl2DU0SIVDAsuTOO8Ac5TbyT78xopnpk3vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877448; c=relaxed/simple;
	bh=DPrfWjEPQJX3g7dXurcNvDzCyZg5usLZaFvsNRlKN0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XdgXNDnkzHtBQf/dMttzpZG5cyaefZxDsBT/aUU9P/3RkOLY9ofQ4k28O2/7+R96pBVcnWIhkkmRtjf0XIj+LsvhEpm1UJOzappsj1+qYAI5mnKkDjsTIwPem/4xap9J2TPvkabUlSbmodTN6wC6OY4MfHlDQVqo+GYxVIkvntE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=Uw0/JnEu; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="Uw0/JnEu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1748877446; x=1780413446;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DPrfWjEPQJX3g7dXurcNvDzCyZg5usLZaFvsNRlKN0g=;
  b=Uw0/JnEuitmu0j0P6kXY3E1VHsm5LXbIT18yHalPU/mcao2WKzHpu81h
   1fVzNTI69PifIxqRaTUipwwNP1Rcf4flgR+Jbw5fbvPfoQxMvIqNsSux4
   vpW2tfnueUzJrcM7ZeTzUwRb3C07by7me9/0SQX3bDohVZIHMfRJN1aWs
   gzmkzaU2vhDi7A21WkajzsHdTZVx1xa53QQuZJm16L4UC0Ug7vrbx2c4l
   HDZlcn1rI2a4kfsApWevxsNtvoYnIvQF50Pj7vt1MdrtQULp1LAwAVc2Q
   YK8//jVG8eqQ9yti6V4Wj7Hg/8CeSU4oeDBma0sJFNjTDqySPDkpeacWr
   Q==;
X-CSE-ConnectionGUID: zwcSJDOXTWaK3kftLFxJLQ==
X-CSE-MsgGUID: v2fk1AusSWWM7B8vfSZPxQ==
Received: from mail-bn7nam10on2094.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([40.107.92.94])
  by ob1.hc6817-7.iphmx.com with ESMTP; 02 Jun 2025 08:17:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYl8rD+p57SJZU62R6Wk/MApENi8A7gcOSLB48IFCmhZe8CyftelXLwxk0ebuOpOHleXxNnOQr25DUDE4CzXc+HHmjTPJTYsfKHKGcbx3MTcFQ4F8w4KvIsPAkfuHATolL77gbicckuHMMJJ24+beOB+3/aev+V+XNGXWWP39WzBbL8EMj1NutXOAQJrPiW/RcKFX7lkH1thvjEVZu7ap11SQkAJbPpPglf3BUX6gqf5d6es10fv9Oq+F4eTbK+DUZiHbPMHgajXaGoKuN26mwrvMnudYaXA7bsPTsaPKIZUBkEyuImibGthhCBaHJEBOYP6PbhPoZDxUwMXE8JYew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DDI9X5S+gVKEsPpITm3aiQfjMqbZjpuxvXAMTR07Gc=;
 b=symj02iRObq+rsoPj2BNiW1CY7+Pj5Yw2VeoRtiTPL94EmHEn+hOtZgAb1Lq9nY58giYdT64rfgsOEwGM82O3f3/SclGqV6Q7tGOykbuLVWGbZsrLeGPTP1jRqAdAfa21ShJSgHEBhkb5aO1omGrbkeSEZN0vAl3yqogDoB+9LtW7Av+Nm2h5Y0XfGGmwz70qk21IWtU1arerBtoWGJvXv5MqMpHUx+CcY4lPy2GhieJlLyJGirmbULmfaCVNYpTtJDX0CtsWtKUgESantNni8gC5lG2uXmMp/ECv+MHeUqFS7bnOX7k+2H8eRBF53e6Dppehi7GKT/0rnIxeXbsXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by SA6PR16MB6660.namprd16.prod.outlook.com (2603:10b6:806:414::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 15:17:21 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::436c:8204:2171:b839]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::436c:8204:2171:b839%5]) with mapi id 15.20.8769.029; Mon, 2 Jun 2025
 15:17:21 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Simon Lindhorst <S.Lindhorst@wut.de>, "'linux-mmc@vger.kernel.org'"
	<linux-mmc@vger.kernel.org>
CC: "'avri.altman@wdc.com'" <avri.altman@wdc.com>, "'ulf.hansson@linaro.org'"
	<ulf.hansson@linaro.org>
Subject: RE: [PATCH] command "rpmb write-key" not working
Thread-Topic: [PATCH] command "rpmb write-key" not working
Thread-Index: AdvTu+/iKCLrzJ2pQsyPxtiaraZZQgAFVatQ
Date: Mon, 2 Jun 2025 15:17:21 +0000
Message-ID:
 <PH7PR16MB619681A79ED1A36434041FCBE562A@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <fa67d9b9358a4eeab2cb43471b08c2ec@wut.de>
In-Reply-To: <fa67d9b9358a4eeab2cb43471b08c2ec@wut.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|SA6PR16MB6660:EE_
x-ms-office365-filtering-correlation-id: f671d729-fdec-40b4-7783-08dda1e89251
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?shvprYi8KrykwluP8Yhm5tzh6NVyYxQOmW9nmg8Mejyo8eV7qmawWOfayv2J?=
 =?us-ascii?Q?WC35Ep/+C/bsyjZCoJDDuHQaxEXEe1S9PgEkqooidqWdLyRaTisxVZDkKcit?=
 =?us-ascii?Q?4npLFGkPKE/jMkiP+awV4USoWGjUpgaS9WEvnblS8092t4bA60SrIJqeQ7Q4?=
 =?us-ascii?Q?2LcNIeVU68r7Wp0/WGYlSQp6MT+JRD9ItzyAGgPkuNtP/LpDSiO0WPWgULSp?=
 =?us-ascii?Q?XJnHbAAxVq6ooMqlu4nD1rlMOM9eHkvaPlN3QcZM9MTcSaeslmb4Qn0gR7fw?=
 =?us-ascii?Q?s0s2SqqAmmpWNQXA2OpKMGnkfLAsmfSeWfXIxb6DFKtZ5/OfjUmPH9SLOMAt?=
 =?us-ascii?Q?G1BK3zZC4AOniXdZxr66Fg+GybJCmu77qo3S/rWDq/qjF/ZWdYQrmKJj7aTn?=
 =?us-ascii?Q?QUdH0QpNfZw9g9KCjL1qlyWlY8EV4pDJ4395B8EfLnU1ec+8I9C2ACbHMJ6T?=
 =?us-ascii?Q?HixJHDDp4TtD0DzhFWhJJe7Af4KbnsY9kHyd6fAUmZC+pS6jsCwL1ImWfNU/?=
 =?us-ascii?Q?8laSjmutNz5uDZUmkolHHLU1tWd560Z/VtppWQXFaHurSRNJxGrKd2CR+ViJ?=
 =?us-ascii?Q?a3Ebbs4iFtC+IPovczjO+k7nSIBkel3+WkD+ubjUrXVjQoGey5nKO1UfW+pr?=
 =?us-ascii?Q?fm5B5VN5KMgjslrfgkkKAmOLz+Y9V0PJG9jW+oCB1VNH3IFt0yp8uYwvuupn?=
 =?us-ascii?Q?wiX7b6j8ldkCx3O54jaEP/GA+wRgoVZib/4+JGCoQDF71rtn2/nMjKDLQi3n?=
 =?us-ascii?Q?nZzgOiEbfuRRELuKBjRODI4i7dgJUnDNLYIxuJ1LJUu1tngpFq8xS+cJT2Z9?=
 =?us-ascii?Q?orNkehTUJJxJXpDUwIi+otulVtupIkcDerB3hsAgmpaqBIMt8Ql62osv8gkM?=
 =?us-ascii?Q?5UXoo4mI1xW3MdgFjIvlFDsiGue73dQE16FTY4KCfNUs/A7HXgS64JVMgAUI?=
 =?us-ascii?Q?68yTcHiu/2ErY1URHaIjA8aqo0p7hQiSVbR5JgPGJb0DEZB54Ts/+CPkFl++?=
 =?us-ascii?Q?cS9Y5woZnAyR22AY9jkBDPmSClxZZNZ3cy00uMwJmh+chslDWBR1FprPf+pK?=
 =?us-ascii?Q?SoNgcU2oRXHkuZY0NDO/k5g+qRQlzKrWJKvla4to7TWe/5vLTJ4wsibmvgoq?=
 =?us-ascii?Q?jD0XHw00y1EJhF3HAv+IkSawzFnH8BAvFJRJ5D+43Zug9hgdS9SRg+T6kyb7?=
 =?us-ascii?Q?81F3JiS2XUGZD1F2Zw9BrQ/67qt0+81x00bwLjD2BmzYtltlF/vTW/y1gyxv?=
 =?us-ascii?Q?lTwNmITP6zV7SKTyLtMxITM9WUwFtO29d0T39WFujk4gK7mWkofkL3TRDW8f?=
 =?us-ascii?Q?ZhSttr2XaQi++zPGg1qAK3VCDi8iaDmxKDXUq6IqMHKVIRO9bvrNjUADeA7C?=
 =?us-ascii?Q?sOuMvCqxkMyNQxRhp9M4Gm3JDLqRzW2JDBOk/3EzPHeS8wjrQwm9xRTDpQov?=
 =?us-ascii?Q?3avurz6hkXM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hSuLd+SYMUgxvZuByS4lYn63bI/sj8hrGxfUoodEm6eKYVbzBc+4lbqWduPE?=
 =?us-ascii?Q?fuFxWuFVe1mb2Xb3qfW9GGLmDJq20JgvGn7lkaMYZfyKaHhQ7CNKN8IIXMJk?=
 =?us-ascii?Q?nMISoWiUubuCneealdY+qdarsy2j4Gwbj4ttneq1Nc6oXgGlC6zvC9s+aLI0?=
 =?us-ascii?Q?0ADf7EmkSQqwHwnLvGhQJY2oKZYqFc6zC/AvxNw16LmnsfYS/7bYmHsGthIG?=
 =?us-ascii?Q?97VRaK1uCaPYan6wA/maGpeYWzx/AY7xq1O+84JCRX4o64n2mNI96wePjAkq?=
 =?us-ascii?Q?YqJWzEZg9GT18fhV3M88ODqfsWnO/Xuvvqz8yqDxeCb0EYcA2HvW6L46ezaV?=
 =?us-ascii?Q?eKWsLXF7CL4PhoAuYCbY2HvuFXfdxW10RqEtI5IsXV/JXujAoeXb7bZJv/O8?=
 =?us-ascii?Q?IE8/O9zXQo1BgAhkUrfw+l7FmOPd8jZOH69B1H0xFHQDYFXj/Z5HundKOZQK?=
 =?us-ascii?Q?ZqktLim4H+33tbQI5cauSoUxy9AnCYCPRkCJBvDKPiOZvRG8z2HZArUuloKi?=
 =?us-ascii?Q?WmTccrNIjHKp2+MJiXeyX75b7/0So5MVnf4W/KoNDLKpaF8oJL9JtTfWvjT4?=
 =?us-ascii?Q?xUjq/fIClbGXcQ6iNAWo2PVQuFv8MnCl0wqU8vngVnBdwdFtyc0bvLjE7V8k?=
 =?us-ascii?Q?Q4mspOxsk0QUZILZzimn2OQhJe26aoOCfm/iFWH1jGx7q3i9qAYm8H9OtQcg?=
 =?us-ascii?Q?RymVVwkhZNdafjKEFiu8+YBHZRy7SWydwxpf4VQWSzvSRm3YFHY+w+N8jef0?=
 =?us-ascii?Q?23mb7L8lO8yZMtnPr0ZSlkJcdk8zOVDXocJEptPPpLLDvp7ItGNkEoFSfVwa?=
 =?us-ascii?Q?uVPRGNUGWG+fEulw/McxExDdyIe0YJPejoxu9/qZSwJUZEpBz+1MAmdZy6Jw?=
 =?us-ascii?Q?N2LBCQ12y/VsoqIJujf95OQvnHozZtJZvaxwo70iUo8mfChMV5RL5ti9uwJF?=
 =?us-ascii?Q?0yEZb6MULvyaBSbQeEJpAMcaPz0i5n3uWqIawgCXkXl5sr09Piz9gHCU88wr?=
 =?us-ascii?Q?LseGy4Yf2zPGXGB0YYGqviE7mnIaQ/DVmaYLZUECSicvWZ3pLmvyWlZRAjTO?=
 =?us-ascii?Q?OLlJhhEIXtcMUTU952oFdFevzrmJZZEY7a4bhokTW7E4mFeIRhRGHtXx6ND/?=
 =?us-ascii?Q?Ihc3zC2rwRbFpVgU+syCyPjwtMfoJycH2HDggHNaPJh33DY6KJIRrWCWKnnt?=
 =?us-ascii?Q?NVmOFYkEoa1KTInpeSUvivRX1RD4e2I2MqkC7dCIfijUcScpD+NWAXkShULW?=
 =?us-ascii?Q?4QweDKzLSSe8Z9j4y45csz9RlNeF+vojiwPK6gWPe6x8U1TK0E1eJ/wA9Unx?=
 =?us-ascii?Q?Rv4QDl/p+18lNPkfJiIlm1v46wQYeIVY/Lm+85mYu+6MFRgMJJtWZdhNY2wf?=
 =?us-ascii?Q?FXe8DfSPratVDj3KCDPBSetcu9uPGK0fTLf6Ymuk14GBipYcImzbvuBbbUZI?=
 =?us-ascii?Q?9Qp6ZEiDOSY0l/5hn6rV8zLGYoId7rFGHI8IZ5cVTFJo2FIwYOATd6y2MGBe?=
 =?us-ascii?Q?fxVpIwR88AboM4e+MICwXT/Cxy8pHu4V0XSTDMhSBufXBPbsE2d1zn/WAxKG?=
 =?us-ascii?Q?aW/6Rr67slO3v+XTjKVa0tbsDY0X+28Ht/dPUn9C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HE9g8HA/D+UWCq574gia/LLYPh55RCJMm08CpFHmox1Z9InLIqpNmqHr7e0OexaRSdbsSCYcvcxrypcSi36kS2lDxaL36VgXmvZ5P1nPH4Dh+hD8VU2GxewEsz4e5uZ0vB5jJgVhos9KZCcp6VL7y6s0E1h1qEEV5DWeXt4OuYlNoNZlXo0WeXMYzFs8etmJ5r6aKWXOne0bzw+e8imWw/7B+FOKO2216xZjgRl6fQ8O0edICLT5sDZnEnNSdNnD6dUx/9moYJPd6mH7uhNDYNiXUawMdSEHEoPaFo6QMNIEXPS5SOlfwJvbYJ2BRU5L/EvnBeqd05IfuHYls2w4yLbucwra4XDfHlqkOBUNGahWK/nkuYQ3K4Yti7K6urVRNF9XK8s1BQz1WB8Aj10XCgrZ2+/a/z+8HnPTFuEwkSd1Bq5rzGfWWbBG0negLzhCsGW9fhzkzIC8XRSgVOH+felRN/gSQM5Z7qu9SmqBDeRe+pDNkERHCyhyJjz5K0OhunxZ3URdjtFhC7yCGd9niCzhWJg9ScT4olqQXBr/d/JmE3Gqs4oQAe4BdfT/aMlsB5yUkUfEumuskP1ZCXGz90WpKktjTWf+82xshXHarcty7Ne97UrVd3Qs5vBrkTMrMNwNe8nRz3MDtcfekdSUlA==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f671d729-fdec-40b4-7783-08dda1e89251
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 15:17:21.5395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fy5Lzdz5mwcWuuwx4A7MrqvTxU4BOx+UXzx/2ZwvRGiO3aSUIc9sk/i3bJtEgV8Urdsd9l8LXlpnx0WT8vryEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR16MB6660

> Hello,
>=20
> I am wondering how the call "rpmb write-key" works. Isn't it the case tha=
t the
> content of the keyfile is read in, but not stored in the structure "struc=
t
> rpmb_frame" before "ret =3D do_rpmb_op(dev_fd, &frame_in, &frame_out, 1);=
"
> (mmc_cmds.c:2296)?
>=20
> If I am right, I suggest the following patch:
>=20
> Fixes: rpmb write-key did not work
>=20
> Fixes: 05051e40351c ("mmc-utils: Refactor RPMB key handling into a separa=
te
> function ")
> Signed-off-by: Simon Lindhorst <s.lindhorst@wut.de>
Reviewed-by: Avri Altman <avri.altman@sandisk.com>

Thanks for fixing this,
Avri

> ---
>  mmc_cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index b2cc3d6..7994223 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2289,7 +2289,7 @@ int do_rpmb_write_key(int nargs, char **argv)
>  		exit(1);
>  	}
>=20
> -	ret =3D rpmb_get_key(argv[2], &frame_in, NULL, false);
> +	ret =3D rpmb_get_key(argv[2], &frame_in, frame_in.key_mac, false);
>  	if (ret)
>  		return ret;
>  	/* Execute RPMB op */
> --
> 2.43.0
>=20
> -- Unsere Aussagen k?nnen Irrt?mer und Missverst?ndnisse enthalten.
> -- Bitte pr?fen Sie die Aussagen f?r Ihren Fall, bevor Sie Entscheidungen=
 auf
> Grundlage dieser Aussagen treffen.
> -------------------------------------------------------------------------=
---------------------
> --------
> Wiesemann & Theis GmbH | Porschestr. 12 | D-42279 Wuppertal
> Gesch?ftsf?hrer: Tobias Theis (M. Eng.)
> Amtsgericht Wuppertal | HRB 6377 | Infos zum Datenschutz:
> https://www.wut.de/datenschutz
> Tel. +49 202/2680-0 | Fax +49 202/2680-265 | https://www.wut.de

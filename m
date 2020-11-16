Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AB5C4742C
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 07:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E50DB2225E
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 07:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qy0lk9yP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgKPHuo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Nov 2020 02:50:44 -0500
Received: from mail-dm6nam11on2067.outbound.protection.outlook.com ([40.107.223.67]:35168
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726524AbgKPHuo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Nov 2020 02:50:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOtnv5Fbec2/1qMjMtnUW47DSuITmYquMptoNxvpigfUNHg0Lss/V5Xb7GLMoeemXVMnDiZFC0XFa4d0OTEFHPeCioh4rKPaZl5DonhEXR0liwKxNxC9Tdpln+dA5HKL4CNeULWz1MTTZ//xs+1sz6zsGOT/Jr6iuiImenS6Bk+uxx/YD1Y5b84oYiTi1qpCpJalv7WGs6VekChZMJaETRk4kHPiYAIGAWh1qw+YYTKbbQqn+p4gOFb+xfSXFi62Yv0UMsbRDKrwG47VBGiQ0JJqKuSTEcz+bZa7ldI7dNfR4VwRV6y83S6olTBErSe78T+1EaQ31EcpkNv1kR5X/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knyI+qeakDG4U6QMYhzJpb2CVh7HJAAAMbESs4H0jD8=;
 b=AU3pywnw6YgekI0GDu/83UMwtY7kxry0k1VisUpPDahC7lD1goZuE6qskTZnDswjI9tmrSBRCRH0wugmopYqrdM5IoWVLgDgi3NQJdR97vDG6ejm5BFIFcFzDMVIg+JFAf26ySioH2MQMSnyVfIuteIhnLFm7IApQwAg6kw2dJ28rIkhe+jUvOncEMJSpDN5ezISo8zWT+acytLCRJfjdFuQ54/ZsPpVAsTRtXP9tLwLFlodmyYVu3lgAncRnRHMwbtudWD0GvcB39lz4L1ZATgXoqmxVMWZoAkXqZRg4TbqkJGnf1mOfaJ+ki0QfmH2+ja1w1uzfc0ukL8TvbgJ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knyI+qeakDG4U6QMYhzJpb2CVh7HJAAAMbESs4H0jD8=;
 b=qy0lk9yP4KQUoAsAFnyXo0OV7BDZyZY8dGI+V0/rmik2sq7qLt7TeG5ybpP0nod/4PsSvN8RZD3ZNSqb0KvOVTJNv8OK51spqSxZPTmM1fOApA/C4K38ANT9Cz5wuaotbff5ukN5yfDwYn8b2BIUeCxDdFqDR+FJpHOs7Z/nwi8=
Received: from DM6PR02MB5898.namprd02.prod.outlook.com (2603:10b6:5:159::13)
 by DM5PR02MB2428.namprd02.prod.outlook.com (2603:10b6:3:3d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25; Mon, 16 Nov 2020 07:50:38 +0000
Received: from DM6PR02MB5898.namprd02.prod.outlook.com
 ([fe80::f1de:3d1c:bd8d:497f]) by DM6PR02MB5898.namprd02.prod.outlook.com
 ([fe80::f1de:3d1c:bd8d:497f%7]) with mapi id 15.20.3541.028; Mon, 16 Nov 2020
 07:50:38 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Manish Narani <MNARANI@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>, Sai Krishna Potthuri <lakshmis@xilinx.com>
Subject: RE: [PATCH] mmc: sdhci-of-arasan: Allow configuring zero tap values
Thread-Topic: [PATCH] mmc: sdhci-of-arasan: Allow configuring zero tap values
Thread-Index: AQHWt4jdqyLias1MGEyvXezJC++3FanKZ4ZA
Date:   Mon, 16 Nov 2020 07:50:38 +0000
Message-ID: <DM6PR02MB58986D442F923EF92F8FF7CDC1E30@DM6PR02MB5898.namprd02.prod.outlook.com>
References: <1605030122-52196-1-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1605030122-52196-1-git-send-email-manish.narani@xilinx.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ee355e1-2c1f-4218-448b-08d88a044f36
x-ms-traffictypediagnostic: DM5PR02MB2428:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR02MB2428003D8CC635E9CE00C011C1E30@DM5PR02MB2428.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aEAzE8v3hWENkWJYh+IZwYYcWqBlgF/EcAsIRNDMjzr23xCVPIDrzRQpoMna+ftV3A+aTmPGPH1GWV5pa0GETCRdMMTryLbgFC1ZLq7MJ9u7QaDa6cx7MhJqGfkJho9oE9EVfTjmBbgpIUB8rw/saBpRVIFhbmANcDfwN9hD/ET13+9Dp3p24VZvMN3wTtR0HR5jfq+V3Itk4FNSv1UEej0mFnX90fKiWtG+BwBC6/h1lVtwzJEDjOdFMDFO/MNFNgnuc4/I3nTevFAM3A9Wi9e9kPIUw9zcmiteftcMh4HnKeDa+NxN9fW+KxLcvxidF8HAven0Lx9yRjYb3PCzog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5898.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(396003)(376002)(136003)(346002)(8676002)(107886003)(71200400001)(52536014)(83380400001)(7696005)(478600001)(4326008)(54906003)(8936002)(33656002)(110136005)(6506007)(316002)(53546011)(9686003)(186003)(44832011)(64756008)(66476007)(66556008)(66446008)(55016002)(26005)(2906002)(66946007)(5660300002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 3pMAeLEF5HfAojHZoQ6DMW3QkbAN0Qo/xvvS8jTxfikBdnoT0qZi89GAZObcXpq9JsP8rrH3TRsuFZ6UiX12Gw7+IPqAF2QyZvd8IwwWTUjfuYhtG1O1oh6SfnHYW4SAI62q2BPXEKApawep4OhloyaqybqEMJNAH7VAn252q2oavgRiklOD+SH44040h5EDUwu7MUOxl4IVvNNx2zbDGeEyqf9Oiiam8AaDD0ECVJYjNJlDTw+PclHNOfdgju5JiV6SZXnuJZRTcXQ5Hxj3bqNJO+PMVIVQ4pWDOx0gJKoeLudr4IaPINiKKqN2ZdRJMtyXnWt4TJ2+xtmU5u9ga2fGtwjBz9u7ugaq+kE4WY8OlXpriT5u3uyAhyi05Ye7U7vnOzTVRHjn+7A+4YAjC7djoiAtIb5YugtIZNEXtWPDyVjoN4BMz7AvhI06Fqcy1NYJHEuTWewU6kWj49EAeFISkJEUvOGZf/FIbz1d4NImJu43ZIP2IoduN06yLNAbd97+QLvt4qGk41hVYdv+j8LeeshkTt5a/tZrOqOsWC7077quYUCHnm/ACKRC3Z5lWwcqwV+hFF5Y3Cq2HgmYVSoxV13LRi+I1vtjGWC85W5mQrm03gnQ7MI3vtKzgC+bzt+1dhPJt4XltYrMHYHtFWfXEDp1wPtEVPQWN6AyjPLz42wqx1hV61bhZFWbZRIa/PkrwK4etrkbm0OskazMh+RFxbIyLNIZ4zdrAtXEjLEwnZA5F5LD+8iJzAv+VX48SQ2JNssIyCyYN5MYBrmT+GhKSQdRMn1kdh7tQWg4FgHi9Wkeu4ck6gbnGhvP2qjumb6b9314MlyvJAiN+NktFAnzBhPd8G0ENCgIx9L+MXRgMqGtTm1XkomBiHA6n12WX2Plze7J5iEIlo3Nj7T1DA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5898.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee355e1-2c1f-4218-448b-08d88a044f36
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 07:50:38.5414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: duiObmc80nQO2biCCUEZuoirVuwOLh7upoN0aOe4fWdMUik7pD8BEQMMprgUkfuLTFwP3yworbeFJ89YSQLyMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2428
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

> -----Original Message-----
> From: Manish Narani <manish.narani@xilinx.com>
> Sent: Tuesday, November 10, 2020 11:12 PM
> To: Michal Simek <michals@xilinx.com>; adrian.hunter@intel.com;
> ulf.hansson@linaro.org
> Cc: linux-arm-kernel@lists.infradead.org; linux-mmc@vger.kernel.org; linu=
x-
> kernel@vger.kernel.org; git <git@xilinx.com>; Manish Narani
> <MNARANI@xilinx.com>; Sai Krishna Potthuri <lakshmis@xilinx.com>
> Subject: [PATCH] mmc: sdhci-of-arasan: Allow configuring zero tap values
>=20
> Allow configuring the Output and Input tap values with zero to avoid
> failures in some cases (one of them is SD boot mode) where the output
> and input tap values may be already set to non-zero.
>=20

Fixes: a5c8b2ae2e51 ("mmc: sdhci-of-arasan: Add support for ZynqMP Platform=
 Tap Delays Setup")

> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.=
com>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 40 ++++++------------------------
>  1 file changed, 8 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-
> of-arasan.c
> index 829ccef87426..100621e55427 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -600,14 +600,8 @@ static int sdhci_zynqmp_sdcardclk_set_phase(struct
> clk_hw *hw, int degrees)
>  	u8 tap_delay, tap_max =3D 0;
>  	int ret;
>=20
> -	/*
> -	 * This is applicable for SDHCI_SPEC_300 and above
> -	 * ZynqMP does not set phase for <=3D25MHz clock.
> -	 * If degrees is zero, no need to do anything.
> -	 */
> -	if (host->version < SDHCI_SPEC_300 ||
> -	    host->timing =3D=3D MMC_TIMING_LEGACY ||
> -	    host->timing =3D=3D MMC_TIMING_UHS_SDR12 || !degrees)
> +	/* This is applicable for SDHCI_SPEC_300 and above */
> +	if (host->version < SDHCI_SPEC_300)
>  		return 0;
>=20
>  	switch (host->timing) {
> @@ -668,14 +662,8 @@ static int
> sdhci_zynqmp_sampleclk_set_phase(struct clk_hw *hw, int degrees)
>  	u8 tap_delay, tap_max =3D 0;
>  	int ret;
>=20
> -	/*
> -	 * This is applicable for SDHCI_SPEC_300 and above
> -	 * ZynqMP does not set phase for <=3D25MHz clock.
> -	 * If degrees is zero, no need to do anything.
> -	 */
> -	if (host->version < SDHCI_SPEC_300 ||
> -	    host->timing =3D=3D MMC_TIMING_LEGACY ||
> -	    host->timing =3D=3D MMC_TIMING_UHS_SDR12 || !degrees)
> +	/* This is applicable for SDHCI_SPEC_300 and above */
> +	if (host->version < SDHCI_SPEC_300)
>  		return 0;
>=20
>  	switch (host->timing) {
> @@ -733,14 +721,8 @@ static int sdhci_versal_sdcardclk_set_phase(struct
> clk_hw *hw, int degrees)
>  	struct sdhci_host *host =3D sdhci_arasan->host;
>  	u8 tap_delay, tap_max =3D 0;
>=20
> -	/*
> -	 * This is applicable for SDHCI_SPEC_300 and above
> -	 * Versal does not set phase for <=3D25MHz clock.
> -	 * If degrees is zero, no need to do anything.
> -	 */
> -	if (host->version < SDHCI_SPEC_300 ||
> -	    host->timing =3D=3D MMC_TIMING_LEGACY ||
> -	    host->timing =3D=3D MMC_TIMING_UHS_SDR12 || !degrees)
> +	/* This is applicable for SDHCI_SPEC_300 and above */
> +	if (host->version < SDHCI_SPEC_300)
>  		return 0;
>=20
>  	switch (host->timing) {
> @@ -804,14 +786,8 @@ static int sdhci_versal_sampleclk_set_phase(struct
> clk_hw *hw, int degrees)
>  	struct sdhci_host *host =3D sdhci_arasan->host;
>  	u8 tap_delay, tap_max =3D 0;
>=20
> -	/*
> -	 * This is applicable for SDHCI_SPEC_300 and above
> -	 * Versal does not set phase for <=3D25MHz clock.
> -	 * If degrees is zero, no need to do anything.
> -	 */
> -	if (host->version < SDHCI_SPEC_300 ||
> -	    host->timing =3D=3D MMC_TIMING_LEGACY ||
> -	    host->timing =3D=3D MMC_TIMING_UHS_SDR12 || !degrees)
> +	/* This is applicable for SDHCI_SPEC_300 and above */
> +	if (host->version < SDHCI_SPEC_300)
>  		return 0;
>=20
>  	switch (host->timing) {
> --
> 2.17.1

Thanks,
Manish

Received: from ix-euc1.prod.hydra.sophos.com (ix-euc1.prod.hydra.sophos.com [94.140.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E02222AF
	for <linux-mmc@vger.kernel.org>; Mon,  2 Jun 2025 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.140.18.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872383; cv=none; b=UEVOa+ZxB+ncrLZM/hby5swCl+MCJoe4SdJRsYterS4zO5V+rXkAbBCVaFbmEcq+/+kYtCcKYE0x0KQRz1zcUo55EKoLriTOZbKId7fRPcNuNsqUxg4Pt2D4AA/4GcEChARUTTNXfkbhlXEJKAq9UaaT3WU6f1SIHqvmMVzU53g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872383; c=relaxed/simple;
	bh=2HQuHMyJNs2kiSqNTZdNNhHXkOhHCn2yBYqwjGGZbh4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dhpIxtIuOuikvsU/hRCR7jCcIurKKKgFe+le0clXDZrGnV/1n7kzSrND95/x4NZYN/a3MCguU8/o4hot0o21jqi13UQzIl41CQllLeyF5V/HVEavP35NMugUW8I9w7YN+JakHSUXnOy2OcGUxWME0jM2nTIGkkEEyyESYEUv04k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wut.de; spf=pass smtp.mailfrom=wut.de; dkim=pass (2048-bit key) header.d=wut.de header.i=@wut.de header.b=BmewAmFB; dkim=pass (2048-bit key) header.d=mail-dkim-eu-central-1.prod.hydra.sophos.com header.i=@mail-dkim-eu-central-1.prod.hydra.sophos.com header.b=OSJBKj9M; arc=none smtp.client-ip=94.140.18.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wut.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wut.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wut.de header.i=@wut.de header.b="BmewAmFB";
	dkim=pass (2048-bit key) header.d=mail-dkim-eu-central-1.prod.hydra.sophos.com header.i=@mail-dkim-eu-central-1.prod.hydra.sophos.com header.b="OSJBKj9M"
Received: from id-euc1.prod.hydra.sophos.com (ip-172-20-0-70.eu-central-1.compute.internal [172.20.0.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ix-euc1.prod.hydra.sophos.com (Postfix) with ESMTPS id 4b9w6f68wPz6S1
	for <linux-mmc@vger.kernel.org>; Mon,  2 Jun 2025 13:43:54 +0000 (UTC)
Received: from ip-172-20-0-196.eu-central-1.compute.internal (ip-172-20-0-196.eu-central-1.compute.internal [127.0.0.1])
	by id-euc1.prod.hydra.sophos.com (Postfix) with ESMTP id 4b9w6V75hVzdZMp
	for <linux-mmc@vger.kernel.org>; Mon,  2 Jun 2025 13:43:46 +0000 (UTC)
X-Sophos-Product-Type: Gateway
X-Sophos-Email-ID: 982dcad0f6c840ea9e9a3b553c039a7b
Received: from mail.wut.de (mail.wut.de [87.193.174.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay-eu-central-1.prod.hydra.sophos.com (Postfix) with ESMTPS id
 4b9w6T55GmznTVW; Mon,  2 Jun 2025 13:43:45 +0000 (UTC)
From: Simon Lindhorst <S.Lindhorst@wut.de>
To: "'linux-mmc@vger.kernel.org'" <linux-mmc@vger.kernel.org>
CC: "'avri.altman@wdc.com'" <avri.altman@wdc.com>, "'ulf.hansson@linaro.org'"
 <ulf.hansson@linaro.org>
Subject: [PATCH] command "rpmb write-key" not working
Thread-Topic: [PATCH] command "rpmb write-key" not working
Thread-Index: AdvTu+/iKCLrzJ2pQsyPxtiaraZZQg==
Date: Mon, 2 Jun 2025 13:44:26 +0000
Message-ID: <fa67d9b9358a4eeab2cb43471b08c2ec@wut.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X_Sophos_TLS_Connection: OPP_TLS_1_3
X_Sophos_TLS_Delivery: true
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748871866; 
 s=sophosd6ff3c4761c84b34a4cc368d61ad26fa; d=wut.de;
 h=Content-Type:Date:Subject:CC:To:From;
 bh=2HQuHMyJNs2kiSqNTZdNNhHXkOhHCn2yBYqwjGGZbh4=;
 b=BmewAmFBIJO1neSaWGlrPjyvbLVv4XsYZFBXEVUuBVjehQTK4P8R0KK7vyTCrav5
 IrwvVevkSsBmmbciB06LydT8rFe5ya4gFExA73jA9SPNCsg7plPozTyL2VGb3F+Nkfi
 m+JqlZATd07TYnV02N3UKgvbETyEXj2X06i/om83UHSElk5OvUMLiK2jDkbbjahOFzz
 Qs9OXpM7uYJRqIbsX1vPD0CPchd9dB2r4F6Y84rJXR+yb3ar3UcVG67HtY7R5JE31Io
 2dsdGeY4y47b7CZTmWsv1BbIvAbXbev8NkaEjTHNhRQEJuOnHeosEjLOPe2nOzQYhXr
 9ccWu17k9g==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748871866; 
 s=v1; d=mail-dkim-eu-central-1.prod.hydra.sophos.com;
 h=Content-Type:Date:Subject:CC:To:From;
 bh=2HQuHMyJNs2kiSqNTZdNNhHXkOhHCn2yBYqwjGGZbh4=;
 b=OSJBKj9MKvkOlWlWhs/JR6fP7oN3bmreH688RRc1dsKtW6o1Kb3d4rIr38bWklKb
 dC86wPS9e60V66c+PEPCYURl22ct0r5m48EfwEs9EiQ8TSY++WqI4WC319p7MucLW9s
 rcxTaYC24ULPK5o0TuSd6O4k+uEREJgfI7TijisyuOWjYSKs18Mc7Vs/F4J4Epjy6MP
 u7pUKyOopzjtv7QO7PDYhhg630ZORBBuzgtIcdGFRlzlVsLO5qSQpTFQUr8z52y4I1/
 bFF3+s692RZaEvQZLBCIE4GWreGNYeP01eGMRni3qa8oyakealN8EC3KTbVRXkXFCLB
 BmNtgCfEsw==
X-Sophos-Email: [eu-central-1] Antispam-Engine: 6.0.2,
 AntispamData: 2025.6.2.131228
X-LASED-SpamProbability: 0.085099
X-LASED-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000, BODY_SIZE_1000_LESS 0.000000,
 BODY_SIZE_2000_LESS 0.000000, BODY_SIZE_5000_LESS 0.000000,
 BODY_SIZE_7000_LESS 0.000000, BODY_SIZE_900_999 0.000000,
 CTE_QUOTED_PRINTABLE 0.000000, HTML_00_01 0.050000, HTML_00_10 0.050000,
 LEGITIMATE_SIGNS 0.000000, MULTIPLE_RCPTS 0.100000,
 MULTIPLE_REAL_RCPTS 0.000000, NO_CTA_URI_FOUND 0.000000,
 NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000, OUTBOUND 0.000000,
 OUTBOUND_SOPHOS 0.000000, SENDER_NO_AUTH 0.000000, SUPERLONG_LINE 0.050000,
 SUSP_DH_NEG 0.000000, TO_NAME_IS_ADDY 0.000000, __ANY_URI 0.000000,
 __BODY_NO_MAILTO 0.000000, __BULK_NEGATE 0.000000, __CC_NAME 0.000000,
 __CC_NAME_DIFF_FROM_ACC 0.000000, __CC_REAL_NAMES 0.000000, __CT 0.000000,
 __CTE 0.000000, __CTYPE_CHARSET_QUOTED 0.000000, __CT_TEXT_PLAIN 0.000000,
 __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
 __FROM_DOMAIN_NOT_IN_BODY 0.000000, __FUR_RDNS_SOPHOS 0.000000,
 __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000, __HAS_MSGID 0.000000,
 __IMP_FROM_MY_ORG 0.000000, __JSON_HAS_SCHEMA_VERSION 0.000000,
 __JSON_HAS_TENANT_DOMAINS 0.000000, __JSON_HAS_TENANT_ID 0.000000,
 __JSON_HAS_TENANT_SCHEMA_VERSION 0.000000, __JSON_HAS_TRACKING_ID 0.000000,
 __MIME_BOUND_CHARSET 0.000000, __MIME_TEXT_ONLY 0.000000,
 __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
 __MSGID_32HEX 0.000000, __MULTIPLE_RCPTS_CC_X2 0.000000,
 __NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS 0.000000,
 __OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
 __OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __PRODUCT_TYPE_GATEWAY 0.000000,
 __RCVD_FROM_DOMAIN 0.000000, __SANE_MSGID 0.000000, __SCAN_D_NEG2 0.000000,
 __SCAN_D_NEG_HEUR2 0.000000, __SUBJ_ALPHA_END 0.000000,
 __SUBJ_STARTS_S_BRACKETS 0.000000, __TO_MALFORMED_2 0.000000,
 __TO_NAME 0.000000, __TO_NAME_DIFF_FROM_ACC 0.000000, __TO_NO_NAME 0.000000,
 __TO_REAL_NAMES 0.000000, __URI_MAILTO 0.000000, __URI_NO_WWW 0.000000,
 __URI_NS 0.000000
X-Sophos-Email-Transport-Route: opps_tls_13:
X-LASED-Impersonation: False
X-LASED-Spam: NonSpam
X-Sophos-MH-Mail-Info-Key: NGI5dzZmNjh3UHo2UzEtMTcyLjIwLjAuMzY=

Hello,

I am wondering how the call "rpmb write-key" works. Isn't it the case that =
the content of the keyfile is read in, but not stored in the structure "str=
uct rpmb_frame" before "ret =3D do_rpmb_op(dev_fd, &frame_in, &frame_out, 1=
);" (mmc_cmds.c:2296)?

If I am right, I suggest the following patch:

Fixes: rpmb write-key did not work

Fixes: 05051e40351c ("mmc-utils: Refactor RPMB key handling into a separate=
 function ")
Signed-off-by: Simon Lindhorst <s.lindhorst@wut.de>
---
 mmc_cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index b2cc3d6..7994223 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2289,7 +2289,7 @@ int do_rpmb_write_key(int nargs, char **argv)
 =09=09exit(1);
 =09}
=20
-=09ret =3D rpmb_get_key(argv[2], &frame_in, NULL, false);
+=09ret =3D rpmb_get_key(argv[2], &frame_in, frame_in.key_mac, false);
 =09if (ret)
 =09=09return ret;
 =09/* Execute RPMB op */
--=20
2.43.0

-- Unsere Aussagen k=F6nnen Irrt=FCmer und Missverst=E4ndnisse enthalten.
-- Bitte pr=FCfen Sie die Aussagen f=FCr Ihren Fall, bevor Sie Entscheidung=
en auf Grundlage dieser Aussagen treffen.
---------------------------------------------------------------------------=
---------------------------
Wiesemann & Theis GmbH | Porschestr. 12 | D-42279 Wuppertal=20
Gesch=E4ftsf=FChrer: Tobias Theis (M. Eng.)=20
Amtsgericht Wuppertal | HRB 6377 | Infos zum Datenschutz: https://www.wut.d=
e/datenschutz
Tel. +49 202/2680-0 | Fax +49 202/2680-265 | https://www.wut.de

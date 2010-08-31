From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: sdhci-stm performance issues
Date: Tue, 31 Aug 2010 12:59:01 +0200
Message-ID: <4C7CE075.8060309@st.com>
References: <107012446AC13D4C90B85672EAF5FB0E9E0FB3CE8E@SAFEX1MAIL3.st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="_002_4C7CE0758060309stcom_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:34819 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752051Ab0HaK7u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Aug 2010 06:59:50 -0400
In-Reply-To: <107012446AC13D4C90B85672EAF5FB0E9E0FB3CE8E@SAFEX1MAIL3.st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>

--_002_4C7CE0758060309stcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

 Hello
The problem was due to the missing both 8BIT and MMC_SPEED supports in
my sdhci driver (comes from the 2.6.32 Kernel series).
I've also added the patch in attachment.

Best Regards
Peppe

On 8/24/2010 5:11 PM, Peppe CAVALLARO wrote:
>
> Hello,
> testing the sdhci-stm.c driver, I sent some weeks ago to the mailing list=
,
> I'm facing some performance issues.
> For example, when copy a file (e.g. ~10MiB) to the card, I've noticed
> that,
> in the sdhci_prepare_data, the maximum value for data->blocks is 248.
>
> The sdhci-stm driver uses the ADMA and:
>   max_seg_size =3D 65536,
>   max_hw_segs =3D 128,
>   max_phys_segs =3D 128,
>   max_req_size =3D 524288,
>   max_blk_size =3D 2048,
>   max_blk_count =3D 65535.
>
> Using my arasan.c code, I've also sent to this mailing list in July,
> I could see that the data->blocks was bigger than 248 and the
> performances were better.
> Note that this driver used the same mmc_host parameters (max_blk_size
> etc.) reported
> above for the sdhci-stm.
>
> What am I missing?
>
> Welcome advice.
>
> Best Regards,
> Giuseppe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--_002_4C7CE0758060309stcom_
Content-Type: text/x-patch;
	name="0001-sdhci-add-MMC_CAP_8_BIT_DATA-in-the-Host-capabiliti.patch"
Content-Description: 0001-sdhci-add-MMC_CAP_8_BIT_DATA-in-the-Host-capabiliti.patch
Content-Disposition: attachment;
	filename="0001-sdhci-add-MMC_CAP_8_BIT_DATA-in-the-Host-capabiliti.patch";
	size=912; creation-date="Tue, 31 Aug 2010 12:59:03 GMT";
	modification-date="Tue, 31 Aug 2010 12:59:03 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiMzQyN2E5MzhlZDA0ZmViZGFhNzI5Y2E1MDBmMjY2Mjc0ZTA2YmQyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogR2l1c2VwcGUgQ2F2YWxsYXJvIDxwZXBwZS5jYXZhbGxhcm9A
c3QuY29tPg0KRGF0ZTogVHVlLCAzMSBBdWcgMjAxMCAwNTo0Mzo0NSArMDIwMA0KU3ViamVjdDog
W1BBVENIIChzaC0yLjYuMzIueSldIHNkaGNpOiBhZGQgTU1DX0NBUF84X0JJVF9EQVRBIGluIHRo
ZSBIb3N0IGNhcGFiaWxpdGllcw0KDQpTaWduZWQtb2ZmLWJ5OiBHaXVzZXBwZSBDYXZhbGxhcm8g
PHBlcHBlLmNhdmFsbGFyb0BzdC5jb20+DQotLS0NCiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMg
fCAgICAyICstDQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMgYi9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLmMNCmluZGV4IDk1NWNhZDkuLjFjNDkzMjYgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLmMNCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYw0KQEAg
LTE3OTksNyArMTc5OSw3IEBAIGludCBzZGhjaV9hZGRfaG9zdChzdHJ1Y3Qgc2RoY2lfaG9zdCAq
aG9zdCkNCiAJbW1jLT5jYXBzID0gTU1DX0NBUF9TRElPX0lSUTsNCiANCiAJaWYgKCEoaG9zdC0+
cXVpcmtzICYgU0RIQ0lfUVVJUktfRk9SQ0VfMV9CSVRfREFUQSkpDQotCQltbWMtPmNhcHMgfD0g
TU1DX0NBUF80X0JJVF9EQVRBOw0KKwkJbW1jLT5jYXBzIHw9IE1NQ19DQVBfNF9CSVRfREFUQSB8
IE1NQ19DQVBfOF9CSVRfREFUQTsNCiANCiAJaWYgKGNhcHMgJiBTREhDSV9DQU5fRE9fSElTUEQp
DQogCQltbWMtPmNhcHMgfD0gTU1DX0NBUF9TRF9ISUdIU1BFRUQ7DQotLSANCjEuNS41LjYNCg0K

--_002_4C7CE0758060309stcom_--

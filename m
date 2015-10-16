From: Austin S Hemmelgarn <ahferroin7@gmail.com>
Subject: Re: [RFC][PATCH] mmc_block: Allow more than 8 partitions per card
Date: Fri, 16 Oct 2015 15:16:06 -0400
Message-ID: <56214CF6.7080105@gmail.com>
References: <1445020846-529-1-git-send-email-john.stultz@linaro.org>
 <56214A01.2030906@gmail.com> <8708065.t39NvS0r8j@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-512; boundary="------------ms050903000701010008060603"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:36738 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbbJPTQT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Oct 2015 15:16:19 -0400
In-Reply-To: <8708065.t39NvS0r8j@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org, Colin Cross <ccross@android.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Ben Hutchings <ben@decadent.org.uk>, Chuanxiao Dong <chuanxiao.dong@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Android Kernel Team <kernel-team@android.com>, linux-mmc@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050903000701010008060603
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2015-10-16 15:08, Arnd Bergmann wrote:
> On Friday 16 October 2015 15:03:29 Austin S Hemmelgarn wrote:
>> On 2015-10-16 14:40, John Stultz wrote:
>>> From: Colin Cross <ccross@android.com>
>>>
>>> It is quite common for Android devices to utilize more
>>> then 8 partitions on internal eMMC storage. This patch,
>>> which has been carried for quite awhile in the AOSP common
>>> tree is necessary in order to support such configurations,
>>> so I wanted to submit it for consideration upstream.
>>
>> Isn't this what CONFIG_MMC_BLOCK_MINORS is for?  It does limit you to
>> 256 minors total, and therefore the number of supported MMC's is equal=

>> to 256/CONFIG_MMC_BLOCK_MINORS, but I've never heard of an Android
>> device with support for more than 4 MMC/SD cards (including eMMC's), a=
nd
>> I would seriously question anyone who has the need for more than 32
>> partitions on the root device for a phone/tablet/television.
>
> The 256 minor limit is really arbitrary, we should not be limited by
> that, and you should have have to decide at compile time whether you
> might need many partitions or many devices, even if we believe that
> nobody will ever need both at the same time.
I didn't mean to imply that I disagree with any of that, I was just=20
trying to get the point across that framing the problem this is trying=20
to solve in such limited terms really isn't the best idea, although I=20
could have gone about doing so in a better way.


--------------ms050903000701010008060603
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
cnQub3JnMSIwIAYDVQQDExlDQSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcN
AQkBFhJzdXBwb3J0QGNhY2VydC5vcmcCAxEt+DANBglghkgBZQMEAgMFAKCCAiEwGAYJKoZI
hvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTUxMDE2MTkxNjA2WjBPBgkq
hkiG9w0BCQQxQgRAQKOZDQ/ErMr4phTthUyBZwjEYG/WDTNuL2lQyxQ9nb9kCYeHzLZgLL98
K2MtHzGc7T/bJOZUFE5jB1W35MNj+jBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFA
MAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGRBgkrBgEEAYI3EAQxgYMwgYAweTEQMA4GA1UE
ChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlD
QSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2Vy
dC5vcmcCAxEt+DCBkwYLKoZIhvcNAQkQAgsxgYOggYAweTEQMA4GA1UEChMHUm9vdCBDQTEe
MBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlDQSBDZXJ0IFNpZ25p
bmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2VydC5vcmcCAxEt+DAN
BgkqhkiG9w0BAQEFAASCAgBqpgEN1V5HX+jvrKxce7Jf8Fm/gZaxJA0aUn0bQcVy0/g9O9qw
/xzQ7+dXI7Wb+iUyG+CtYx20Nae4yO2IkUQhZQc+If3mIo5skc85I9XsZZlEIqKuB1qfmzBG
96US8aq3qm0n2vhWs1h+Wf/a3ty+YTY0guiKE3A2WBeUunMDyigCy4nxxe4TqyS3obdzgQpc
sLdmDNuRuyDyn9kLFGBCg0gMPm+PfVd/Fl7U2S2e/LH0Rm1CIESe7BamN4X0gAAvj03rnGr9
+v8q/l/Nz+CKsm8KRBC1jrl93e2rFexKEL+2WJAWiAmevM6e5BC93CSXdVhrTa25u14i+9Pe
h/AW6UzzXdIODdd3QTlzloziRl11i3oyoIyBp1ur9Lkaq92yk5/M1/G/TvGLDax3R5qsEoAO
7/reu+DnmhnaRkwb25plsssjPf0fsIdGnx9QeHiUR1FD97xRSl68ZtbfNVEI4EvhSKpqrpta
PBfJs72RL8Fl91yyoyvGAqbqgAGC/ll3yhrQDRaNVKgIARYtRSvCg2o0BP5epE1Du/bLmDwn
Hm0Iiy0kc9xW0Ap7MLvCk34iBYCMVoDsJG70yQGqeOBsETzYNexx+q1GDP6/c2U5Il9Tow/I
2eDb6Dey2hswRtpxBXsI0aMNakYU+vIEwkAQyx3KP+NtQP3wxkV39Ya0cQAAAAAAAA==
--------------ms050903000701010008060603--

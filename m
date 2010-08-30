From: Esben Haabendal <esbenhaabendal@gmail.com>
Subject: Re: [PATCH] of_mmc_spi: add card detect irq support
Date: Mon, 30 Aug 2010 18:04:51 +0200
Message-ID: <AANLkTik3rNpFCYDR7dxiFN_3dvxZmsSjt8PsoC415JM-@mail.gmail.com>
References: <AANLkTikH+H6+sXN_hcfm_guvUwgM-NKQ83nCwgAk-23G@mail.gmail.com>
	<20100830132914.GA32266@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00c09f99defae20966048f0c9fbe
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62769 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755873Ab0H3QEw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Aug 2010 12:04:52 -0400
Received: by qyk9 with SMTP id 9so3014814qyk.19
        for <linux-mmc@vger.kernel.org>; Mon, 30 Aug 2010 09:04:51 -0700 (PDT)
In-Reply-To: <20100830132914.GA32266@oksana.dev.rtsoft.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, David Brownell <dbrownell@users.sourceforge.net>, linux-mmc@vger.kernel.org

--00c09f99defae20966048f0c9fbe
Content-Type: text/plain; charset=ISO-8859-1

Hi

Comments below, and updated patch attached.

On Mon, Aug 30, 2010 at 3:29 PM, Anton Vorontsov <cbouatmailru@gmail.com> wrote:
>>> +static int of_mmc_spi_init(struct device *dev,
>> +                          irqreturn_t (*irqhandler)(int, void *), void *mmc)
>> +{
>> +       struct of_mmc_spi *oms = to_of_mmc_spi(dev);
>
> Please add an empty line here.

Ok.

>> +       return request_threaded_irq(
>> +               oms->detect_irq, NULL, irqhandler, 0, dev_name(dev), mmc);
>
> I'd write it this way:
>
> return request_threaded_irq(oms->detect_irq, NULL, irqhandler,
>                            0, dev_name(dev), mmc);
>
> But that's a matter of taste.

Fine with me.

>> +}
>> +
>> +static void of_mmc_spi_exit(struct device *dev, void *mmc)
>> +{
>> +       struct of_mmc_spi *oms = to_of_mmc_spi(dev);
>
> Empty line.

Ok.

>> +       free_irq(oms->detect_irq, mmc);
>> +}
>> +
>>  struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
>>  {
>>         struct device *dev = &spi->dev;
>> @@ -121,8 +136,14 @@ struct mmc_spi_platform_data
>> *mmc_spi_get_pdata(struct spi_device *spi)
>>         if (gpio_is_valid(oms->gpios[WP_GPIO]))
>>                 oms->pdata.get_ro = of_mmc_spi_get_ro;
>>
>> -       /* We don't support interrupts yet, let's poll. */
>> -       oms->pdata.caps |= MMC_CAP_NEEDS_POLL;
>> +       oms->detect_irq = irq_of_parse_and_map(np, 0);
>> +       if (oms->detect_irq != NO_IRQ) {
>
> I'd write "if (oms->detect_irq)", which is a bit more natural
> (and still correct, 0 is the only invalid VIRQ number).

Most other architectures has NO_IRQ defined to -1, so I will stick
with the NO_IRQ comparsion.
Hopefully, arm users will soon enjoy this driver/wrapper soon also.

>> +               oms->pdata.init = of_mmc_spi_init;
>> +               oms->pdata.exit = of_mmc_spi_exit;
>> +       }
>> +       else {
>
> } else {

Done.

> Plus, please add an appropriate interrupts = <> bindings into
> Documentation/powerpc/dts-bindings/mmc-spi-slot.txt.

Done.

> And on the next resend, be sure to add Andrew Morton
> <akpm@linux-foundation.org>, David Brownell
> <dbrownell@users.sourceforge.net>, and linux-mmc@vger.kernel.org
> the Cc list.

Should be there now.

/Esben

--00c09f99defae20966048f0c9fbe
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-of_mmc_spi-add-card-detect-irq-support.patch"
Content-Disposition: attachment;
	filename="0001-of_mmc_spi-add-card-detect-irq-support.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gdhis5o30

b2ZfbW1jX3NwaTogYWRkIGNhcmQgZGV0ZWN0IGlycSBzdXBwb3J0CgpTaWduZWQtb2ZmLWJ5OiBF
c2JlbiBIYWFiZW5kYWwgPGVoYUBkb3JlZGV2ZWxvcG1lbnQuZGs+Ci0tLQogLi4uL3Bvd2VycGMv
ZHRzLWJpbmRpbmdzL21tYy1zcGktc2xvdC50eHQgICAgICAgICAgfCAgICA5ICsrKysrKy0KIGRy
aXZlcnMvbW1jL2hvc3Qvb2ZfbW1jX3NwaS5jICAgICAgICAgICAgICAgICAgICAgIHwgICAyNiAr
KysrKysrKysrKysrKysrKystCiAyIGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9wb3dlcnBjL2R0cy1iaW5k
aW5ncy9tbWMtc3BpLXNsb3QudHh0IGIvRG9jdW1lbnRhdGlvbi9wb3dlcnBjL2R0cy1iaW5kaW5n
cy9tbWMtc3BpLXNsb3QudHh0CmluZGV4IGMzOWFjMjguLjg5YTAwODQgMTAwNjQ0Ci0tLSBhL0Rv
Y3VtZW50YXRpb24vcG93ZXJwYy9kdHMtYmluZGluZ3MvbW1jLXNwaS1zbG90LnR4dAorKysgYi9E
b2N1bWVudGF0aW9uL3Bvd2VycGMvZHRzLWJpbmRpbmdzL21tYy1zcGktc2xvdC50eHQKQEAgLTcs
OCArNywxMyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOgogLSB2b2x0YWdlLXJhbmdlcyA6IHR3byBj
ZWxscyBhcmUgcmVxdWlyZWQsIGZpcnN0IGNlbGwgc3BlY2lmaWVzIG1pbmltdW0KICAgc2xvdCB2
b2x0YWdlIChtViksIHNlY29uZCBjZWxsIHNwZWNpZmllcyBtYXhpbXVtIHNsb3Qgdm9sdGFnZSAo
bVYpLgogICBTZXZlcmFsIHJhbmdlcyBjb3VsZCBiZSBzcGVjaWZpZWQuCi0tIGdwaW9zIDogKG9w
dGlvbmFsKSBtYXkgc3BlY2lmeSBHUElPcyBpbiB0aGlzIG9yZGVyOiBDYXJkLURldGVjdCBHUElP
LAorCitPcHRpb25hbCBwcm9wZXJ0aWVzOgorLSBncGlvcyA6IG1heSBzcGVjaWZ5IEdQSU9zIGlu
IHRoaXMgb3JkZXI6IENhcmQtRGV0ZWN0IEdQSU8sCiAgIFdyaXRlLVByb3RlY3QgR1BJTy4KKy0g
aW50ZXJydXB0cyA6IHRoZSBpbnRlcnJ1cHQgb2YgYSBjYXJkIGRldGVjdCBpbnRlcnJ1cHQuCist
IGludGVycnVwdC1wYXJlbnQgOiB0aGUgcGhhbmRsZSBmb3IgdGhlIGludGVycnVwdCBjb250cm9s
bGVyIHRoYXQKKyAgc2VydmljZXMgaW50ZXJydXB0cyBmb3IgdGhpcyBkZXZpY2UuCiAKIEV4YW1w
bGU6CiAKQEAgLTIwLDQgKzI1LDYgQEAgRXhhbXBsZToKIAkJCSAmcWVfcGlvX2QgMTUgMD47CiAJ
CXZvbHRhZ2UtcmFuZ2VzID0gPDMzMDAgMzMwMD47CiAJCXNwaS1tYXgtZnJlcXVlbmN5ID0gPDUw
MDAwMDAwPjsKKwkJaW50ZXJydXB0cyA9IDw0Mj47CisJCWludGVycnVwdC1wYXJlbnQgPSA8JlBJ
Qz47CiAJfTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvb2ZfbW1jX3NwaS5jIGIvZHJp
dmVycy9tbWMvaG9zdC9vZl9tbWNfc3BpLmMKaW5kZXggMTI0N2U1ZC4uNTUzMGRlZiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9tbWMvaG9zdC9vZl9tbWNfc3BpLmMKKysrIGIvZHJpdmVycy9tbWMvaG9z
dC9vZl9tbWNfc3BpLmMKQEAgLTM0LDYgKzM0LDcgQEAgZW51bSB7CiBzdHJ1Y3Qgb2ZfbW1jX3Nw
aSB7CiAJaW50IGdwaW9zW05VTV9HUElPU107CiAJYm9vbCBhbG93X2dwaW9zW05VTV9HUElPU107
CisJaW50IGRldGVjdF9pcnE7CiAJc3RydWN0IG1tY19zcGlfcGxhdGZvcm1fZGF0YSBwZGF0YTsK
IH07CiAKQEAgLTYxLDYgKzYyLDIyIEBAIHN0YXRpYyBpbnQgb2ZfbW1jX3NwaV9nZXRfcm8oc3Ry
dWN0IGRldmljZSAqZGV2KQogCXJldHVybiBvZl9tbWNfc3BpX3JlYWRfZ3BpbyhkZXYsIFdQX0dQ
SU8pOwogfQogCitzdGF0aWMgaW50IG9mX21tY19zcGlfaW5pdChzdHJ1Y3QgZGV2aWNlICpkZXYs
CisJCQkgICBpcnFyZXR1cm5fdCAoKmlycWhhbmRsZXIpKGludCwgdm9pZCAqKSwgdm9pZCAqbW1j
KQoreworCXN0cnVjdCBvZl9tbWNfc3BpICpvbXMgPSB0b19vZl9tbWNfc3BpKGRldik7CisKKwly
ZXR1cm4gcmVxdWVzdF90aHJlYWRlZF9pcnEob21zLT5kZXRlY3RfaXJxLCBOVUxMLCBpcnFoYW5k
bGVyLCAwLAorCQkJCSAgICBkZXZfbmFtZShkZXYpLCBtbWMpOworfQorCitzdGF0aWMgdm9pZCBv
Zl9tbWNfc3BpX2V4aXQoc3RydWN0IGRldmljZSAqZGV2LCB2b2lkICptbWMpCit7CisJc3RydWN0
IG9mX21tY19zcGkgKm9tcyA9IHRvX29mX21tY19zcGkoZGV2KTsKKworCWZyZWVfaXJxKG9tcy0+
ZGV0ZWN0X2lycSwgbW1jKTsKK30KKwogc3RydWN0IG1tY19zcGlfcGxhdGZvcm1fZGF0YSAqbW1j
X3NwaV9nZXRfcGRhdGEoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkKIHsKIAlzdHJ1Y3QgZGV2aWNl
ICpkZXYgPSAmc3BpLT5kZXY7CkBAIC0xMjEsOCArMTM4LDEzIEBAIHN0cnVjdCBtbWNfc3BpX3Bs
YXRmb3JtX2RhdGEgKm1tY19zcGlfZ2V0X3BkYXRhKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpCiAJ
aWYgKGdwaW9faXNfdmFsaWQob21zLT5ncGlvc1tXUF9HUElPXSkpCiAJCW9tcy0+cGRhdGEuZ2V0
X3JvID0gb2ZfbW1jX3NwaV9nZXRfcm87CiAKLQkvKiBXZSBkb24ndCBzdXBwb3J0IGludGVycnVw
dHMgeWV0LCBsZXQncyBwb2xsLiAqLwotCW9tcy0+cGRhdGEuY2FwcyB8PSBNTUNfQ0FQX05FRURT
X1BPTEw7CisJb21zLT5kZXRlY3RfaXJxID0gaXJxX29mX3BhcnNlX2FuZF9tYXAobnAsIDApOwor
CWlmIChvbXMtPmRldGVjdF9pcnEgIT0gTk9fSVJRKSB7CisJCW9tcy0+cGRhdGEuaW5pdCA9IG9m
X21tY19zcGlfaW5pdDsKKwkJb21zLT5wZGF0YS5leGl0ID0gb2ZfbW1jX3NwaV9leGl0OworCX0g
ZWxzZSB7CisJCW9tcy0+cGRhdGEuY2FwcyB8PSBNTUNfQ0FQX05FRURTX1BPTEw7CisJfQogCiAJ
ZGV2LT5wbGF0Zm9ybV9kYXRhID0gJm9tcy0+cGRhdGE7CiAJcmV0dXJuIGRldi0+cGxhdGZvcm1f
ZGF0YTsKLS0gCjEuNy4xLjEKCg==
--00c09f99defae20966048f0c9fbe--
